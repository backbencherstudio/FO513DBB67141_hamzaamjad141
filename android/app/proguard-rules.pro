# Stripe
-keep class com.stripe.** { *; }
-dontwarn com.stripe.android.**

# Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Google Play Services Auth
-keep class com.google.android.gms.auth.** { *; }
-dontwarn com.google.android.gms.auth.**

# Keep Flutter plugin registrant classes
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.engine.** { *; }

# Keep Parcelable implementations
-keepclassmembers class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator CREATOR;
}

# Keep annotations (for reflection)
-keepattributes *Annotation*

# Keep native method names (JNI)
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep enum names
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
