package kr.ac.jejunu.daumtrack.dao;

public class BusStationDataVo {
	private int stationId;
	private String stationNm;
	private float latitude;
	private float longitude;
	
	//	StationId int
	public int getStationId() {
		return stationId;
	}
	
	public void setStationId(int stationId) {
		this.stationId = stationId;
	}
	
	//	StationName	string
	public String getStationNm() {
		return stationNm;
	}
	
	public void setStationNm(String stationNm) {
		this.stationNm = stationNm;
	}
	
	//	Latitude(localY) float
	public float getLatitude() {
		return latitude;
	}
	
	public void setLatitude(float latitude) {
		this.latitude = latitude;
	}
	
	//	Longitude(localX) float
	public float getLongitude() {
		return longitude;
	}
	
	public void setLongitude(float longitude) {
		this.longitude = longitude;
	}
}
