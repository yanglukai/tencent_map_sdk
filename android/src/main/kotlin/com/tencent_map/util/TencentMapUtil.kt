package com.tencent_map.util

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Matrix
import android.graphics.Paint
import android.graphics.Typeface
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.tencent_map.R

object TencentMapUtil {
    fun getUserLocationBitMap(context: Context, resourceId: Int): Bitmap {
        var bitmap = BitmapFactory.decodeResource(context.resources, resourceId)
        val width = bitmap.width
        val height = bitmap.height
        val newWidth = 110
        val newHeight = 110
        val widthScale = newWidth.toFloat() / width
        val heightScale = newHeight.toFloat() / height
        val matrix = Matrix()
        matrix.postScale(widthScale, heightScale)
        bitmap = Bitmap.createBitmap(bitmap, 0, 0, width, height, matrix, true)
        return bitmap
    }

    fun clusterBitmapWithCustomerName(context: Context, title: String): Bitmap {
        val width = 340
        val height = 140

        val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        var backgroundBitmap = BitmapFactory.decodeResource(context.resources, R.drawable.map_customer)
        backgroundBitmap = Bitmap.createScaledBitmap(backgroundBitmap, width, height, false)
        canvas.drawBitmap(backgroundBitmap, 0f, 0f, null)

        val paint = Paint()
        paint.setColor(Color.WHITE)
        paint.textSize = 40f
        paint.setTypeface(Typeface.DEFAULT)

        var resTitle = title
        val textWidth = paint.measureText(title)
        val fixedWidth = 250
        var endIndex = title.length
        if (textWidth > fixedWidth) {
            while (paint.measureText(title, 0, endIndex) > fixedWidth - paint.measureText("...")) {
                endIndex--
            }
            resTitle = title.substring(0, endIndex) + "..."
        }
        val x = (width - paint.measureText(resTitle)) / 2
        // 在画布上绘制文本
        canvas.drawText(resTitle, x, 70f, paint)
        return bitmap
    }

    // ========== 定位权限相关方法 ==========

    // 定位权限请求码，自定义即可，建议100以上
    const val LOCATION_PERMISSION_REQUEST_CODE = 101

    // 基础定位权限数组（Android 9及以下只需要这两个）
    private val BASIC_LOCATION_PERMISSIONS = arrayOf(
            android.Manifest.permission.ACCESS_FINE_LOCATION,
            android.Manifest.permission.ACCESS_COARSE_LOCATION
    )

    // Android10+ 包含后台定位的权限数组
    private val FULL_LOCATION_PERMISSIONS: Array<String>
        get() {
            return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                arrayOf(
                        android.Manifest.permission.ACCESS_FINE_LOCATION,
                        android.Manifest.permission.ACCESS_COARSE_LOCATION,
                        android.Manifest.permission.ACCESS_BACKGROUND_LOCATION
                )
            } else {
                BASIC_LOCATION_PERMISSIONS
            }
        }

    /**
     * 判断【基础定位权限】是否已授权 (前台定位够用)
     */
    fun hasBasicLocationPermission(activity: Activity): Boolean {
        return BASIC_LOCATION_PERMISSIONS.all { permission ->
            ContextCompat.checkSelfPermission(activity, permission) == PackageManager.PERMISSION_GRANTED
        }
    }

    /**
     * 判断【完整定位权限】是否已授权 (包含后台定位，Android10+)
     */
    fun hasFullLocationPermission(activity: Activity): Boolean {
        return FULL_LOCATION_PERMISSIONS.all { permission ->
            ContextCompat.checkSelfPermission(activity, permission) == PackageManager.PERMISSION_GRANTED
        }
    }

    /**
     * 申请【基础定位权限】
     */
    fun requestBasicLocationPermission(activity: Activity) {
        ActivityCompat.requestPermissions(activity, BASIC_LOCATION_PERMISSIONS, LOCATION_PERMISSION_REQUEST_CODE)
    }

    /**
     * 申请【完整定位权限】（推荐）
     */
    fun requestFullLocationPermission(activity: Activity) {
        ActivityCompat.requestPermissions(activity, FULL_LOCATION_PERMISSIONS, LOCATION_PERMISSION_REQUEST_CODE)
    }

    /**
     * 判断用户是否「拒绝权限且勾选了不再询问」
     */
    fun isPermissionDeniedForever(activity: Activity): Boolean {
        val permissions = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) FULL_LOCATION_PERMISSIONS else BASIC_LOCATION_PERMISSIONS
        return permissions.any { permission ->
            ContextCompat.checkSelfPermission(activity, permission) != PackageManager.PERMISSION_GRANTED
                    && !ActivityCompat.shouldShowRequestPermissionRationale(activity, permission)
        }
    }

    /**
     * 跳转到App设置页，让用户手动开启权限
     */
    fun goToAppSetting(activity: Activity) {
        val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS).apply {
            data = Uri.fromParts("package", activity.packageName, null)
        }
        activity.startActivity(intent)
    }
}
