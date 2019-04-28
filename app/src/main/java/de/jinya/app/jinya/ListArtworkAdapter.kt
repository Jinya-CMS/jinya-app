package de.jinya.app.art.artworks.jinya

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.AsyncTask
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.ImageView
import de.jinya.app.R
import de.jinya.app.framework.autoSizeImageView
import de.jinya.app.model.Artwork
import org.jetbrains.anko.*
import org.jetbrains.anko.cardview.v7.cardView
import java.io.File

class ListArtworkAdapter() : BaseAdapter() {
    var items: List<Artwork> = ArrayList()

    fun setArtworks(items: List<Artwork>) {
        this.items = items

        notifyDataSetChanged()
    }

    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        val item = getItem(position)

        return with(parent!!.context) {
            frameLayout {
                lparams(width = matchParent, height = wrapContent)
                cardView {
                    verticalLayout {
                        DownloadImageTask(autoSizeImageView {}, parent.context).execute(item.picture.toString())
                        verticalLayout {
                            padding = dip(16)
                            textView(item.name).lparams(width = matchParent, height = wrapContent)
                            if (item.description != null) {
                                textView(item.description).lparams(width = matchParent, height = wrapContent)
                            }
                        }.lparams(width = matchParent, height = wrapContent)
                        linearLayout {
                            themedButton(R.string.action_artwork_edit, R.style.PrimaryFlatButton)
                            themedButton(R.string.action_artwork_delete, R.style.NegativeFlatButton)
                        }.lparams(width = matchParent, height = wrapContent)
                    }.lparams(width = matchParent, height = wrapContent)
                }.lparams(width = matchParent, height = wrapContent) {
                    bottomMargin = dip(16)
                }
            }
        }
    }

    override fun getItem(position: Int): Artwork {
        return items[position]
    }

    override fun getItemId(position: Int): Long {
        return items[position].hashCode().toLong()
    }

    override fun getCount(): Int {
        return items.count()
    }

    private inner class DownloadImageTask(internal var bmImage: ImageView, private val context: Context) :
        AsyncTask<String, Void, Bitmap>() {

        override fun doInBackground(vararg urls: String): Bitmap? {
            val urldisplay = urls[0]
            val filename = Uri.parse(urldisplay)?.path
            val file = File(context.cacheDir, filename)
            try {
                if (!file.exists()) {
                    File(file.parent).mkdirs()
                    val `in` = java.net.URL(urldisplay).openStream()
                    file.createNewFile()
                    val fileOutStream = file.outputStream()
                    `in`.copyTo(fileOutStream)
                    fileOutStream.close()
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }

            return BitmapFactory.decodeFile(file.absolutePath)
        }

        override fun onPostExecute(result: Bitmap) {
            bmImage.setImageBitmap(result)
        }
    }
}

