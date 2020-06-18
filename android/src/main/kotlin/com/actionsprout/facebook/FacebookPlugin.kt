package com.actionsprout.facebook

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log

import androidx.annotation.NonNull

import com.facebook.AccessToken
import com.facebook.CallbackManager
import com.facebook.FacebookCallback
import com.facebook.FacebookException
import com.facebook.appevents.AppEventsLogger
import com.facebook.login.LoginBehavior
import com.facebook.login.LoginManager
import com.facebook.login.LoginResult

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
import io.flutter.plugin.common.PluginRegistry.Registrar

import java.util.Date

fun Date.toJSON(): Long {
    return this.getTime()
}

fun Set<String>.toJSON(): List<String> {
    return this.toList()
}

fun AccessToken.toJSON(): Map<String, Any> {
    return mapOf(
            "app_id" to this.applicationId,
            "declined" to this.declinedPermissions.toJSON(),
            "expires_at" to this.expires.toJSON(),
            "granted" to this.permissions.toJSON(),
            "token" to this.token,
            "user_id" to this.userId
            )
}

fun HashMap<String, Any>.toBundle(): Bundle {
    val result = Bundle()

    for ((key, value) in this) {
        when {
            value is String -> result.putString(key, value)
        }
    }

    return result
}

/** FacebookPlugin */
public class FacebookPlugin : ActivityAware, ActivityResultListener, FlutterPlugin, MethodCallHandler {
    // private val loginManager: LoginManager = LoginManager.getInstance()
    private val callbackManager: CallbackManager = CallbackManager.Factory.create()
    private var activity: Activity? = null
    private var appEventsLogger: AppEventsLogger? = null

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "actionsprout.com/facebook")
            var instance = FacebookPlugin()
            instance.activity = registrar.activity()
            instance.appEventsLogger = AppEventsLogger.newLogger(instance.activity)
            channel.setMethodCallHandler(instance)
            registrar.addActivityResultListener(instance)
        }
    }

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(binding.getFlutterEngine().getDartExecutor(), "actionsprout.com/facebook")

        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {}

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.arguments !is HashMap<*, *>) {
            result.error("INVALID_ARGS", "Arguments must be a Map<String, dynamic>", null)
            return
        }

        val args = call.arguments as HashMap<String, Any>

        when {
            call.method == "log_in" -> loginWithFacebook(args, result)
            call.method == "log_out" -> logoutWithFacebook(args, result)
            call.method == "get_current_access_token" -> getCurrentAccessToken(args, result)
            call.method == "log_app_event" -> logAppEvent(args, result)
            else -> result.notImplemented()
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        return callbackManager.onActivityResult(requestCode, resultCode, data)
    }

    override fun onAttachedToActivity(@NonNull binding: ActivityPluginBinding) {
        activity = binding.getActivity()
        appEventsLogger = AppEventsLogger.newLogger(activity)
        binding.addActivityResultListener(this)
    }

    override fun onReattachedToActivityForConfigChanges(@NonNull binding: ActivityPluginBinding) {
        activity = binding.getActivity()
        appEventsLogger = AppEventsLogger.newLogger(activity)
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        activity = null
        appEventsLogger = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
        appEventsLogger = null
    }

    fun loginWithFacebook(@NonNull args: HashMap<String, Any>, @NonNull result: Result) {
        if (args["permissions"] !is ArrayList<*>) {
            result.error(
                    "INVALID_ARG",
                    "Method 'login' requires permissions as a list of Strings.",
                    null
            )
            return
        }

        val permissions = args["permissions"] as ArrayList<String>

        LoginManager.getInstance().registerCallback(callbackManager,
                object : FacebookCallback<LoginResult> {
                    override fun onSuccess(loginResult: LoginResult) {
                        result.success(mapOf(
                                "status" to ".success",
                                "declined" to loginResult.recentlyDeniedPermissions.toJSON(),
                                "granted" to loginResult.recentlyGrantedPermissions.toJSON(),
                                "token" to loginResult.accessToken.toJSON()
                        ))
                    }

                    override fun onCancel() {
                        result.success(mapOf(
                                "status" to ".cancelled"
                        ))
                    }

                    override fun onError(error: FacebookException) {
                        result.success(mapOf(
                                "status" to ".failed",
                                "error" to error?.message
                        ))
                    }
                })
        LoginManager.getInstance().logInWithReadPermissions(activity, args["permissions"] as ArrayList<String>)
    }

    fun logoutWithFacebook(@NonNull args: HashMap<String, Any>, @NonNull result: Result) {
        LoginManager.getInstance().logOut()
        result.success(null)
    }

    fun getCurrentAccessToken(@NonNull args: HashMap<String, Any>, @NonNull result: Result) {
        result.success(AccessToken.getCurrentAccessToken()?.toJSON())
    }

    fun logAppEvent(@NonNull args: HashMap<String, Any>, @NonNull result: Result) {
        if (appEventsLogger !is AppEventsLogger) {
            result.error("INVALID_STATE", "No current Activity.", null)
            return
        }

        if (args["name"] !is String) {
            result.error(
                    "INVALID_ARG",
                    "Method 'fire_app_event' requires name parameter as a String.",
                    null
            )
            return
        }

        val name = args["name"] as String
        val logger = appEventsLogger as AppEventsLogger

        if (args["parameters"] is HashMap<*, *>) {
            logger.logEvent(name, (args["parameters"] as HashMap<String, Any>).toBundle())
        } else {
            logger.logEvent(name)
        }

        result.success(null)
    }
}
