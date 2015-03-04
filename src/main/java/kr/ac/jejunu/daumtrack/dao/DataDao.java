package kr.ac.jejunu.daumtrack.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service(value = "dataDao")
public class DataDao {
	@Resource(name = "dataMapper")
	private DataMapper dataMapper;
	
	public List<DataVo> getSelect() {
		return this.dataMapper.select();
	}
	
	public DataVo getSelectOne(int routeId) {
		return this.dataMapper.selectOne(routeId);
	}
	
	public void insert(DataVo dataVo) {
		this.dataMapper.insert(dataVo);
	}
	
	public void update(DataVo dataVo) {
		this.dataMapper.update(dataVo);
	}
	
	public void delete(int routeId) {
		this.dataMapper.delete(routeId);
	}

	public List<Map<String, String>> selectBusStationList(Map<String, String> qParam) {
		return this.dataMapper.selectBusStationList(qParam);
	}
	
	public BusStationDataVo selectBusStation(int stationId) {
		return this.dataMapper.selectBusStation(stationId);
	}
}
