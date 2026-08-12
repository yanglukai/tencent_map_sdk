package com.tencent_map.handler.searcher

import android.content.Context
import android.util.Log
import com.tencent.lbssearch.HttpResponseListener
import com.tencent.lbssearch.TencentSearch
import com.tencent.lbssearch.httpresponse.BaseObject
import com.tencent.lbssearch.`object`.param.Address2GeoParam
import com.tencent.lbssearch.`object`.param.ExploreParam
import com.tencent.lbssearch.`object`.param.Geo2AddressParam
import com.tencent.lbssearch.`object`.param.SuggestionParam
import com.tencent.lbssearch.`object`.result.Address2GeoResultObject
import com.tencent.lbssearch.`object`.result.DistrictResultObject
import com.tencent.lbssearch.`object`.result.ExploreResultObject
import com.tencent.lbssearch.`object`.result.Geo2AddressResultObject
import com.tencent.lbssearch.`object`.result.SuggestionResultObject
import com.tencent_map.TAG
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class TencentSearcherPluginHandler(
        methodChannel: MethodChannel,
        private val context: Context,
) {

    private var tencentSearch: TencentSearch? = null

    init {
        methodChannel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            this.onMethodCall(call, result)
        }
    }

    private fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.v(TAG, call.method)
        val args = call.arguments

        when (call.method) {

            "setApiKey" -> {
                val arg = call.arguments as? Map<String, *>
                val apiKey = arg?.get("apiKey") as? String
                val secretKey = arg?.get("secretKey") as? String
                tencentSearch = TencentSearch(context, apiKey, secretKey)
                result.success(null)
            }

            "searchWithSuggestionSearchOption" -> {
                val param = args as? SuggestionParam
                param?.let {
                    tencentSearch?.suggestion(param, object : HttpResponseListener<BaseObject> {
                        override fun onSuccess(arg0: Int, arg1: BaseObject?) {
                            val resultObj = arg1 as? SuggestionResultObject
                            result.success(resultObj?.data)
                        }

                        override fun onFailure(p0: Int, p1: String?, p2: Throwable?) {
                            Log.e(TAG, "error code: $p0, msg: $p1")
                            result.success(null)
                        }
                    })
                }
            }

            "searchWithDistrictList" -> {
                tencentSearch?.getDistrictList(object : HttpResponseListener<BaseObject> {
                    override fun onSuccess(p0: Int, p1: BaseObject?) {
                        val resultObj = p1 as? DistrictResultObject
                        result.success(resultObj?.result)
                    }

                    override fun onFailure(p0: Int, p1: String?, p2: Throwable?) {
                        Log.e(TAG, "error code: $p0, msg: $p1")
                        result.success(null)
                    }
                })
            }

            "searchWithGeoCodeSearchOption" -> {
                val param = args as? Address2GeoParam
                param?.let {
                    tencentSearch?.address2geo(param, object : HttpResponseListener<BaseObject> {
                        override fun onSuccess(p0: Int, p1: BaseObject?) {
                            val resultObj = p1 as? Address2GeoResultObject
                            result.success(resultObj?.result)
                        }

                        override fun onFailure(p0: Int, p1: String?, p2: Throwable?) {
                            Log.e(TAG, "error code: $p0, msg: $p1")
                            result.success(null)
                        }
                    })
                }
            }

            "searchWithReverseGeoCodeSearchOption" -> {
                val param = args as? Geo2AddressParam
                param?.let {
                    tencentSearch?.geo2address(param, object : HttpResponseListener<BaseObject> {
                        override fun onSuccess(p0: Int, p1: BaseObject?) {
                            val resultObj = p1 as? Geo2AddressResultObject
                            result.success(resultObj?.result)
                        }

                        override fun onFailure(p0: Int, p1: String?, p2: Throwable?) {
                            Log.e(TAG, "error code: $p0, msg: $p1")
                            result.success(null)
                        }
                    })
                }
            }

            "searchWithPoiExploreSearchOption" -> {
                val param = args as? ExploreParam
                param?.let {
                    tencentSearch?.explore(param, object : HttpResponseListener<BaseObject> {
                        override fun onSuccess(p0: Int, p1: BaseObject?) {
                            val resultObj = p1 as? ExploreResultObject
                            result.success(resultObj?.data)
                        }

                        override fun onFailure(p0: Int, p1: String?, p2: Throwable?) {
                            Log.e(TAG, "error code: $p0, msg: $p1")
                            result.success(null)
                        }
                    })
                }
            }

            else -> {
                result.notImplemented()
            }
        }
    }
}