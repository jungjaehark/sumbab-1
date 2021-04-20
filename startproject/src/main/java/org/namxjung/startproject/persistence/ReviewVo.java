package org.namxjung.startproject.persistence;

import java.util.Date;

public class ReviewVo {
	private String id;
	private String star;
	private Date regdate;
	private String content;
	
	public ReviewVo(String id, String star, Date regdate, String content) {
		super();
		this.id = id;
		this.star = star;
		this.regdate = regdate;
		this.content = content;
	}

	public ReviewVo() {}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getStar() {
		return star;
	}

	public void setStar(String star) {
		this.star = star;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "ReviewVo [id=" + id + ", star=" + star + ", regdate=" + regdate + ", content=" + content + "]";
	}
	
	
	
	
	
}
