package kr.ac.jejunu.daumtrack.dao;

public class DataVo {
	private int dstStationId;
	private int orgtStationId;
	private int routeId;
	private String routeNm;
	private int routeNum;
	private String routeSubNm;
	private int stationCnt;
	
	//	DstStationId int
	public int getDstStationId() {
		return dstStationId;
	}
	
	public void setDstStationId(int dstStationId) {
		this.dstStationId = dstStationId;
	}
	
	//	OrgtStationId int
	public int getOrgtStationId() {
		return orgtStationId;
	}
	
	public void setOrgtStationId(int orgtStationId) {
		this.orgtStationId = orgtStationId;
	}
	
	//	RouteId int
	public int getRouteId() {
		return routeId;
	}
	
	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}
	
	//	RouteName string
	public String getRouteNm() {
		return routeNm;
	}
	
	public void setRouteNm(String routeNm) {
		this.routeNm = routeNm;
	}
	
	//	RouteNumber int
	public int getRouteNum() {
		return routeNum;
	}
	
	public void setRouteNum(int routeNum) {
		this.routeNum = routeNum;
	}
	
	//	RouteSubName string
	public String getRouteSubNm() {
		return routeSubNm;
	}
	
	public void setRouteSubNm(String routeSubNm) {
		this.routeSubNm = routeSubNm;
	}
	
	//	StationCount int
	public int getStationCnt() {
		return stationCnt;
	}
	
	public void setStationCnt(int stationCnt) {
		this.stationCnt = stationCnt;
	}
}
