package org.nojo.domain;

public class QuestionVO {
	
	//질문번호
	private int question_no;	
	
	//제목
	private String question_title;		
	
	//내용
	private String question_contetn;	
	
	//등록일
	private String question_reg_date;	
	
	//구분
	private String question_gb;			
	
	//공개여부
	private boolean question_visible;	
	
	//도메인
	private String clz_domain;			
	
	//아이디
	private String mem_id;				
	
	
	@Override
	public String toString() {
		return "QuestionVO [question_no=" + question_no + ", question_title=" + question_title + ", question_contetn="
				+ question_contetn + ", question_reg_date=" + question_reg_date + ", question_gb=" + question_gb
				+ ", question_visible=" + question_visible + ", clz_domain=" + clz_domain + ", mem_id=" + mem_id + "]";
	}

	//region Getter
	public int getQuestion_no() {
		return question_no;
	}


	public String getQuestion_title() {
		return question_title;
	}


	public String getQuestion_contetn() {
		return question_contetn;
	}


	public String getQuestion_reg_date() {
		return question_reg_date;
	}


	public String getQuestion_gb() {
		return question_gb;
	}


	public boolean isQuestion_visible() {
		return question_visible;
	}


	public String getClz_domain() {
		return clz_domain;
	}


	public String getMem_id() {
		return mem_id;
	}
	//End region
	
	
	
	//region Setter
	public void setQuestion_no(int question_no) {
		this.question_no = question_no;
	}

	public void setQuestion_title(String question_title) {
		this.question_title = question_title;
	}

	public void setQuestion_contetn(String question_contetn) {
		this.question_contetn = question_contetn;
	}

	public void setQuestion_reg_date(String question_reg_date) {
		this.question_reg_date = question_reg_date;
	}

	public void setQuestion_gb(String question_gb) {
		this.question_gb = question_gb;
	}

	public void setQuestion_visible(boolean question_visible) {
		this.question_visible = question_visible;
	}

	public void setClz_domain(String clz_domain) {
		this.clz_domain = clz_domain;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	//End region
	
}
