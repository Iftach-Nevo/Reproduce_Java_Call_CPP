package com.example.call_javacpp;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import com.example.javacpplib.JavaCPP;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.flutter.java";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            if (call.method.equals("powerMethod")) {
                                int val = call.argument("int");
                                int power = powerFunc(val);
                                if (power != -1) {
                                    result.success(power);
                                } else {
                                    result.error("ERROR", "Function Unavailable", null);
                                }

                            } else if (call.method.equals("rootMethod")) {
                                double val = call.argument("double");
                                double power = rootFunc(val);
                                if (power != -1) {
                                    result.success(power);
                                } else {
                                    result.error("ERROR", "Function Unavailable", null);
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );

    }

    private int powerFunc(int i) {
        return JavaCPP.powerMethod(i);
    }

    private double rootFunc(double i) {
        return JavaCPP.rootMethod(i);
    }
}
