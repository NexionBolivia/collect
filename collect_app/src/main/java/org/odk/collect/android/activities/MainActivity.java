package org.odk.collect.android.activities;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import org.odk.collect.android.R;
import org.odk.collect.android.application.Collect;
import org.odk.collect.android.preferences.GeneralSharedPreferences;
import org.odk.collect.android.preferences.PreferencesActivity;

import javax.inject.Inject;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends CollectAbstractActivity {

    @Inject
    GeneralSharedPreferences generalSharedPreferences;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Collect.getInstance().getComponent().inject(this);
        setContentView(R.layout.main_activity);

        configureFlutterModule();

        findViewById(R.id.option2).setOnClickListener(v -> startActivity(
                new Intent(this, MainMenuActivity.class)
        ));
        findViewById(R.id.option3).setOnClickListener(v -> startActivity(
                new Intent(this, PreferencesActivity.class)
        ));
    }

    private void configureFlutterModule() {

        FlutterEngine flutterEngine = new FlutterEngine(this);

        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "FLUTTER_MODULE")
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("GET_ALL_PREFERENCES")) {
                                result.success(generalSharedPreferences.getAll());
                            }
                        }
                );

        FlutterEngineCache
                .getInstance()
                .put("my_engine_id", flutterEngine);

        findViewById(R.id.option1).setOnClickListener(v -> startActivity(
                FlutterActivity.withCachedEngine("my_engine_id").build(this)
        ));
    }
}
