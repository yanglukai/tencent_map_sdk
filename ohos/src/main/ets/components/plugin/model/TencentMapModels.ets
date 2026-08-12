import { Any } from "@ohos/flutter_ohos"
import { InfoWindowInfo, LatLng } from "@tencentmap/map"

export class TmLatLng {
  latitude: number | undefined
  longitude: number | undefined

  constructor(latitude: number | undefined, longitude: number | undefined) {
    this.latitude = latitude
    this.longitude = longitude
  }

  static fromMap(map: Map<string, Any | undefined>): TmLatLng {
    return new TmLatLng(map.get("latitude"), map.get("longitude"))
  }

  toMap(): Map<string, Any | undefined> {
    return new Map([
      ["latitude", this.latitude],
      ["longitude", this.longitude]
    ])
  }

  toLatLng(): LatLng {
    return new LatLng(this.latitude ?? 0.0, this.longitude ?? 0.0)
  }
}

export class TmPoint {
  x: number | undefined
  y: number | undefined

  constructor(x: number | undefined, y: number | undefined) {
    this.x = x
    this.y = y
  }

  static fromMap(map: Map<string, Any | undefined>): TmPoint {
    return new TmPoint(map.get("x"), map.get("y"))
  }

  toMap(): Map<string, Any | undefined> {
    return new Map([
      ["x", this.x],
      ["y", this.y]
    ])
  }
}

export class TmConfig {
  mapType: number | undefined
  mapStyle: number | undefined
  centerLatLng: TmLatLng | undefined
  showsUserLocation: boolean | undefined
  showsScale: boolean | undefined
  scaleOrigin: TmPoint | undefined
  showsBuildings: boolean | undefined
  shows3DBuildings: boolean | undefined
  showsPoi: boolean | undefined
  labelSize: number | undefined
  showsBaseMap: boolean | undefined
  showsCompass: boolean | undefined
  compassOffset: TmPoint | undefined
  preferredFramesPerSecond: number | undefined
  logoCenter: TmPoint | undefined
  logoScale: number | undefined
  zoomLevel: number | undefined
  minZoomLevel: number | undefined
  maxZoomLevel: number |undefined
  zoomEnabled: boolean | undefined
  keepCenterDuringZoom: boolean | undefined
  scrollEnabled: boolean | undefined
  overlookingEnabled: boolean | undefined
  rotateEnabled: boolean | undefined
  alwaysTriggerDidTapCoordinateEnabled: boolean | undefined

  constructor(
    mapType: number | undefined,
    mapStyle: number | undefined,
    centerLatLng: TmLatLng | undefined,
    showsUserLocation: boolean | undefined,
    showsScale: boolean | undefined,
    scaleOrigin: TmPoint | undefined,
    showsBuildings: boolean | undefined,
    shows3DBuildings: boolean | undefined,
    showsPoi: boolean | undefined,
    labelSize: number | undefined,
    showsBaseMap: boolean | undefined,
    showsCompass: boolean | undefined,
    compassOffset: TmPoint | undefined,
    preferredFramesPerSecond: number | undefined,
    logoCenter: TmPoint | undefined,
    logoScale: number | undefined,
    zoomLevel: number | undefined,
    minZoomLevel: number | undefined,
    maxZoomLevel: number | undefined,
    zoomEnabled: boolean | undefined,
    keepCenterDuringZoom: boolean | undefined,
    scrollEnabled: boolean | undefined,
    overlookingEnabled: boolean | undefined,
    rotateEnabled: boolean | undefined,
    alwaysTriggerDidTapCoordinateEnabled: boolean | undefined,
  ) {
    this.mapType = mapType
    this.mapStyle = mapStyle
    this.centerLatLng = centerLatLng
    this.showsUserLocation = showsUserLocation
    this.showsScale = showsScale
    this.scaleOrigin = scaleOrigin
    this.showsBuildings = showsBuildings
    this.shows3DBuildings = shows3DBuildings
    this.showsPoi = showsPoi
    this.labelSize = labelSize
    this.showsBaseMap = showsBaseMap
    this.showsCompass = showsCompass
    this.compassOffset = compassOffset
    this.preferredFramesPerSecond = preferredFramesPerSecond
    this.logoCenter = logoCenter
    this.logoScale = logoScale
    this.zoomLevel = zoomLevel
    this.minZoomLevel = minZoomLevel
    this.maxZoomLevel = maxZoomLevel
    this.zoomEnabled = zoomEnabled
    this.keepCenterDuringZoom = keepCenterDuringZoom
    this.scrollEnabled = scrollEnabled
    this.overlookingEnabled = overlookingEnabled
    this.rotateEnabled = rotateEnabled
    this.alwaysTriggerDidTapCoordinateEnabled = alwaysTriggerDidTapCoordinateEnabled
  }

  static fromMap(map: Map<string, Any | undefined>): TmConfig {
    const mapType: number | undefined = map.get("mapType")
    const mapStyle: number | undefined = map.get("mapStyle")
    const centerLatLngMap: Map<string, Any | undefined> | undefined = map.get("centerLatLn")
    let centerLatLng: TmLatLng | undefined
    if (centerLatLngMap) {
      centerLatLng = TmLatLng.fromMap(centerLatLngMap)
    }
    const showsUserLocation: boolean | undefined = map.get("showsUserLocation")
    const showsScale: boolean | undefined = map.get("showsScale")
    const scaleOriginMap: Map<string, Any | undefined> | undefined = map.get("scaleOrigin")
    let scaleOrigin: TmPoint | undefined
    if (scaleOriginMap) {
      scaleOrigin = TmPoint.fromMap(scaleOriginMap)
    }
    const showsBuildings: boolean | undefined = map.get("showsBuildings")
    const shows3DBuildings: boolean |undefined = map.get("shows3DBuildings")
    const showsPoi: boolean | undefined = map.get("showsPoi")
    const labelSize: number | undefined = map.get("labelSize")
    const showsBaseMap: boolean | undefined = map.get("showsBaseMap")
    const showsCompass: boolean | undefined = map.get("showsCompass")
    const compassOffsetMap: Map<string, Any | undefined> | undefined = map.get("compassOffset")
    let compassOffset: TmPoint | undefined
    if (compassOffsetMap) {
      compassOffset = TmPoint.fromMap(compassOffsetMap)
    }
    const preferredFramesPerSecond: number | undefined = map.get("preferredFramesPerSecond")
    const logoCenterMap: Map<string, Any | undefined> | undefined = map.get("logoCenter")
    let logoCenter: TmPoint | undefined
    if (logoCenterMap) {
      logoCenter = TmPoint.fromMap(logoCenterMap)
    }
    const logoScale: number | undefined = map.get("logoScale")
    const zoomLevel: number | undefined = map.get("zoomLevel")
    const minZoomLevel: number | undefined = map.get("minZoomLevel")
    const maxZoomLevel: number | undefined = map.get("maxZoomLevel")
    const zoomEnabled: boolean | undefined = map.get("zoomEnabled")
    const keepCenterDuringZoom: boolean | undefined = map.get("keepCenterDuringZoom")
    const scrollEnabled: boolean | undefined = map.get("scrollEnabled")
    const overlookingEnabled: boolean | undefined = map.get("overlookingEnabled")
    const rotateEnabled: boolean | undefined = map.get("rotateEnabled")
    const alwaysTriggerDidTapCoordinateEnabled: boolean | undefined = map.get("alwaysTriggerDidTapCoordinateEnabled")

    return new TmConfig(
      mapType,
      mapStyle,
      centerLatLng,
      showsUserLocation,
      showsScale,
      scaleOrigin,
      showsBuildings,
      shows3DBuildings,
      showsPoi,
      labelSize,
      showsBaseMap,
      showsCompass,
      compassOffset,
      preferredFramesPerSecond,
      logoCenter,
      logoScale,
      zoomLevel,
      minZoomLevel,
      maxZoomLevel,
      zoomEnabled,
      keepCenterDuringZoom,
      scrollEnabled,
      overlookingEnabled,
      rotateEnabled,
      alwaysTriggerDidTapCoordinateEnabled
    )
  }

  toMap(): Map<string, Any> {
    let map: Map<string, Any> = new Map()
    map.set("mapType", this.mapType)
    map.set("mapStyle", this.mapStyle)
    map.set("centerLatLng", this.centerLatLng?.toMap())
    map.set("showsUserLocation", this.showsUserLocation)
    map.set("showsScale", this.showsScale)
    map.set("scaleOrigin", this.scaleOrigin?.toMap())
    map.set("showsBuildings", this.showsBuildings)
    map.set("shows3DBuildings", this.shows3DBuildings)
    map.set("showsPoi", this.showsPoi)
    map.set("labelSize", this.labelSize)
    map.set("showsBaseMap", this.showsBaseMap)
    map.set("showsCompass", this.showsCompass)
    map.set("compassOffset", this.compassOffset?.toMap())
    map.set("preferredFramesPerSecond", this.preferredFramesPerSecond)
    map.set("logoCenter", this.logoCenter?.toMap())
    map.set("logoScale", this.logoScale)
    map.set("zoomLevel", this.zoomLevel)
    map.set("minZoomLevel", this.minZoomLevel)
    map.set("maxZoomLevel", this.maxZoomLevel)
    map.set("zoomEnabled", this.zoomEnabled)
    map.set("keepCenterDuringZoom", this.keepCenterDuringZoom)
    map.set("scrollEnabled", this.scrollEnabled)
    map.set("overlookingEnabled", this.overlookingEnabled)
    map.set("rotateEnabled", this.rotateEnabled)
    map.set("alwaysTriggerDidTapCoordinateEnabled", this.alwaysTriggerDidTapCoordinateEnabled)
    return map
  }
}

@Observed
export class TmClusterInfo {
  latLng: TmLatLng | undefined
  title: string | undefined
  customId: string | undefined
  custom: Map<string, Any> | undefined
  infoWindowInfo: InfoWindowInfo

  constructor(latLng: TmLatLng | undefined,
    title: string | undefined,
    customId: string | undefined,
    custom: Map<string, Any> | undefined,
  ) {
    this.latLng = latLng
    this.title = title
    this.customId = customId
    this.custom = custom
    this.infoWindowInfo = new InfoWindowInfo()
  }

  getLatLng(): LatLng {
    return new LatLng(this.latLng?.latitude ?? 0.0, this.latLng?.longitude ?? 0.0)
  }

  static fromMap(map: Map<string, Any>): TmClusterInfo {
    const latLngMap: Map<string, Any> | undefined = map.get("latLng")
    let _latLng: TmLatLng | undefined
    if (latLngMap) {
      _latLng = TmLatLng.fromMap(latLngMap)
    }
    return new TmClusterInfo(_latLng, map.get("title"), map.get("customId"), map.get("custom"))
  }

  toMap(): Map<string, Any> {
    let map: Map<string, Any> = new Map()
    map.set("latLng", this.latLng?.toMap())
    map.set("title", this.title)
    map.set("customId", this.customId)
    map.set("custom", this.custom)
    return map
  }
}

export class TmPoiInfo {
  latLng: TmLatLng | undefined
  uid: string | undefined
  name: string | undefined

  constructor(latLng: TmLatLng | undefined,
    uid: string | undefined,
    name: string | undefined) {
    this.latLng = latLng
    this.uid = uid
    this.name = name
  }

  static fromMap(map: Map<string, Any>): TmPoiInfo {
    const latLngMap: Map<string, Any> | undefined = map.get("latLng")
    let _latLng: TmLatLng | undefined
    if (latLngMap) {
      _latLng = TmLatLng.fromMap(latLngMap)
    }
    return new TmPoiInfo(_latLng, map.get("uid"), map.get("name"))
  }

  toMap(): Map<string, Any> {
    let map: Map<string, Any> = new Map()
    map.set("latLng", this.latLng?.toMap())
    map.set("uid", this.uid)
    map.set("name", this.name)
    return map
  }
}

export class TmClusterAnnotation {
  latLng: TmLatLng | undefined
  items: Array<TmClusterInfo> | undefined

  constructor(latLng: TmLatLng | undefined,
    items: Array<TmClusterInfo> | undefined) {
    this.latLng = latLng
    this.items = items
  }

  static fromMap(map: Map<string, Any>): TmClusterAnnotation {
    const latLngMap: Map<string, Any> | undefined = map.get("latLng")
    let _latLng: TmLatLng | undefined
    if (latLngMap) {
      _latLng = TmLatLng.fromMap(latLngMap)
    }
    const itemList: Array<Map<string, Any>> = map.get("items")
    const items: Array<TmClusterInfo> = itemList.map((map: Map<string, Any>) => TmClusterInfo.fromMap(map))
    return new TmClusterAnnotation(_latLng, items)
  }

  toMap(): Map<string, Any> {
    const mapList: Array<Map<string, Any>> | undefined = this.items?.map((item: TmClusterInfo) => item.toMap())
    let map: Map<string, Any> = new Map()
    map.set("latLng", this.latLng?.toMap())
    map.set("items", mapList)
    return map
  }
}

export class TmError {
  code: number | undefined
  message: string | undefined

  constructor(code: number | undefined,
    message: string | undefined) {
    this.code = code
    this.message = message
  }

  static fromMap(map: Map<string, Any>): TmError {
    const code: number | undefined = map.get("code")
    const message: string | undefined = map.get("message")
    return new TmError(code, message)
  }

  toMap(): Map<string, Any> {
    let map: Map<string, Any> = new Map()
    map.set("code", this.code)
    map.set("message", this.message)
    return map
  }
}