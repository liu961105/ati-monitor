/**Ajax响应实体对象
 * @author wang
 *
 */
package com.dfmy.entity;

public class ResultEntity {

	private String success;
	private String message;
	private Object data;

	public String getSuccess() {
		return success;
	}

	public void setSuccess(String success) {
		this.success = success;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Object getData() {
		if (data == null) {
			data = "";
		}
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}
}
