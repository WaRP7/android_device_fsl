package com.embest.demo.magneticcalibraion;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Handler;
//import android.support.v7.app.AppCompatActivity;
import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

import java.lang.reflect.Method;
import java.util.Properties;

public class MainActivity extends Activity {

    private SensorManager sm=null;
    private Sensor aSensor=null;
    private Sensor mSensor=null;
    private Boolean mCalibrationAlmostGood=Boolean.FALSE;

    float[] accelerometerValues=new float[3];
    float[] magneticFieldValues=new float[3];
    float[] values=new float[3];
    float[] rotate=new float[9];

    private Handler mHandler=new Handler();
    private Runnable mRunnable=new Runnable() {
        @Override
        public void run() {
            // TODO Auto-generated method stub
            //要做的事情
            //get percentage
            String percents= getProperty("sys.sensors.magcalibration","Unknown");

            int per=0;
            try { per = Integer.parseInt(percents); } catch (NumberFormatException e) {e.printStackTrace();}
            if (per > 50)
                mCalibrationAlmostGood = Boolean.TRUE;
            Log.d("MainActivity", "get percentage as:"+per +"%");
            if (mCalibrationAlmostGood) {
                String maginfo = "Compass: yaw:" + values[0] + "\n" +
                        "         pitch:" + values[1] + "\n" +
                        "         roll:" + values[2] + "\n";
                tvMagInfo.setText(maginfo);
            }

            tvPercentage.setText(percents+" %");
            if (per==100)
                tvPercentage.setText(percents+" % Completed!");

            mHandler.postDelayed(this, 2000);
        }
    };
    private TextView tvPercentage;
    private TextView tvMagInfo;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        tvPercentage = (TextView)findViewById(R.id.tv_percent);
        tvMagInfo = (TextView)findViewById(R.id.tv_maginfo);
        //open mag sensor
        sm=(SensorManager)getSystemService(Context.SENSOR_SERVICE);
        aSensor=sm.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
        mSensor=sm.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD);
    }
    @Override
    protected void onPause() {
        // TODO Auto-generated method stub
        super.onPause();
        sm.unregisterListener(myListener);
    }

    @Override
    protected void onResume() {
        // TODO Auto-generated method stub
        super.onResume();
        mHandler.postDelayed(mRunnable, 1000);
        sm.registerListener(myListener, aSensor, SensorManager.SENSOR_DELAY_GAME);
        sm.registerListener(myListener, mSensor, SensorManager.SENSOR_DELAY_GAME);    }

    protected String getProperty(String key, String defaultValue) {
        String value = defaultValue;
        try {
            Class<?> c = Class.forName("android.os.SystemProperties");
            Method get = c.getMethod("get", String.class, String.class);
            value = (String)(get.invoke(c, key, "unknown" ));
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            return value;
        }
    }


    final SensorEventListener myListener=new SensorEventListener(){

        @Override
        public void onAccuracyChanged(Sensor sensor, int accuracy) {
            // TODO Auto-generated method stub

        }

        @Override
        public void onSensorChanged(SensorEvent event) {
            // TODO Auto-generated method stub
            if(event.sensor.getType()==Sensor.TYPE_ACCELEROMETER){
                accelerometerValues=event.values;
            }
            if(event.sensor.getType()==Sensor.TYPE_MAGNETIC_FIELD){
                magneticFieldValues=event.values;
            }

            //Log.d(TAG,"magneticFieldValues:"+magneticFieldValues[0]+":"+magneticFieldValues[1]+""+magneticFieldValues[2] );

            SensorManager.getRotationMatrix(rotate, null, accelerometerValues, magneticFieldValues);
            SensorManager.getOrientation(rotate, values);
            //经过SensorManager.getOrientation(rotate, values);得到的values值为弧度
            //转换为角度
            values[0]=(float)Math.toDegrees(values[0]);
            values[1]=(float)Math.toDegrees(values[1]);
            values[2]=(float)Math.toDegrees(values[2]);
            //textview.setText("x="+values[0]+"y="+values[1]+"z="+values[2] +"\n"+
            //        "magneticFieldValues:"+magneticFieldValues[0]+":"+magneticFieldValues[1]+":"+magneticFieldValues[2]);

//
//            if (mCount++ > 10) {
//                final float rad2deg = (float)(180.0f/Math.PI);
//                mCount = 0;
//                Log.d("Compass", "yaw: " + (int)(mOrientation[0]*rad2deg) +
//                        "  pitch: " + (int)(mOrientation[1]*rad2deg) +
//                        "  roll: " + (int)(mOrientation[2]*rad2deg) +
//                        "  incl: " + (int)(incl*rad2deg)
//                );
//            }
        }};


}
