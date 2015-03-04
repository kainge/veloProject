package kr.ac.jejunu.daumtrack.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository(value = "dataMapper")
public interface DataMapper {
	List<DataVo> select();
	DataVo selectOne(int routeId);
	void insert(DataVo dataVo);
	void update(DataVo dataVo);
	void delete(int routeId);
	List<Map<String, String>> selectBusStationList(Map<String, String> qParam);
	BusStationDataVo selectBusStation(int stationId);
}
