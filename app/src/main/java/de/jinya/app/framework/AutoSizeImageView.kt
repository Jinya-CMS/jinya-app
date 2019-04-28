package de.jinya.app.framework

import android.content.Context
import android.view.View
import android.view.ViewManager
import android.widget.ImageView
import org.jetbrains.anko.AnkoViewDslMarker
import org.jetbrains.anko.custom.ankoView

class AutoSizeImageView(context: Context) : ImageView(context, null) {
    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        val d = drawable

        if (d != null) {
            val width = View.MeasureSpec.getSize(widthMeasureSpec)
            val height =
                Math.ceil((width.toFloat() * d.intrinsicHeight.toFloat() / d.intrinsicWidth.toFloat()).toDouble())
                    .toInt()
            setMeasuredDimension(width, height)
        } else {
            super.onMeasure(widthMeasureSpec, heightMeasureSpec)
        }
    }
}

fun ViewManager.autoSizeImageView(): AutoSizeImageView = autoSizeImageView() {}
fun ViewManager.autoSizeImageView(init: (@AnkoViewDslMarker AutoSizeImageView).() -> Unit): AutoSizeImageView {
    return ankoView({ ctx: Context -> AutoSizeImageView(ctx) }, theme = 0) { init() }
}