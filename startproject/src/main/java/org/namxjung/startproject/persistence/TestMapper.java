package org.namxjung.startproject.persistence;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class TestMapper implements RowMapper<TestVo> {

	@Override
	public TestVo mapRow(ResultSet rs, int rowNum) throws SQLException {
		return new TestVo(
				rs.getInt("store_num"),
				rs.getString("address"));
	}
	

}
