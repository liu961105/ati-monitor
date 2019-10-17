<%@tag pageEncoding="UTF-8"%>
<%@ attribute name="page" type="com.bi.util.Page" required="true"%>
<%@ attribute name="paginationSize" type="java.lang.Integer" required="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
int current =  page.getPageNo();
int begin = Math.max(1, current - paginationSize/2);
int end = Math.min(begin + (paginationSize - 1), Integer.parseInt(String.valueOf(page.getTotalPages())));
Long totalCount = page.getTotalCount();

request.setAttribute("current", current);
request.setAttribute("begin", begin);
request.setAttribute("end", end);
request.setAttribute("totalCount", totalCount);
%>
<input type="hidden" id="orderField" name="orderField" value="${orderField}"/> 
<input type="hidden" id="orderSort" name="orderSort" value="${orderSort}"/>
<input type="hidden" id="id" name="id" value="${id}"/>
<div class="list-footer">
 	<div class="list-page">
         <ul class="list-pagecontent">
             <% if (page.isHasPre()){%>
	               	<li><a class="leftborder" onclick="pageGoto('1','${sortType}','${searchParams}','${page.totalPages}','${orderField}','${orderSort}')"> « </a></li>
	                <li><a onclick="pageGoto('${current-1}','${sortType}','${searchParams}','${page.totalPages}','${orderField}','${orderSort}')"> < </a></li>
	         <%}else{%>
	                <li><a class="leftborder"> « </a></li>
	                <li><a> < </a></li>
	         <%} %>
			<c:forEach var="i" begin="${begin}" end="${end}">
	            <c:choose>
	                <c:when test="${i == current}">
	                    <li><a class="active" onclick="pageGoto('${i}','${sortType}','${searchParams}','${page.totalPages}','${orderField}','${orderSort}')">${i}</a></li>
	                </c:when>
	                <c:otherwise>
	                    <li><a onclick="pageGoto('${i}','${sortType}','${searchParams}','${page.totalPages}','${orderField}','${orderSort}')">${i}</a></li>
	                </c:otherwise>
	            </c:choose>
	        </c:forEach>
		  	 <% if (page.isHasNext()){%>
	               	<li><a onclick="pageGoto('${current+1}','${sortType}','${searchParams}','${page.totalPages}','${orderField}','${orderSort}')"> > </a></li>
	                <li><a onclick="pageGoto('${page.totalPages}','${sortType}','${searchParams}','${page.totalPages}','${orderField}','${orderSort}')"> » </a></li>
	         <%}else{%>
	                <li class="disabled"><a> > </a></li>
	                <li class="disabled"><a> » </a></li>
	         <%} %>
             	<li class="pageGoto">
                	<span>总记录</span>
                    <span class="num">${totalCount}</span>
                    <span>总页数</span>
                    <span class="num">${page.totalPages}</span>
                    <span>当前第</span>
                    <span class="num">${current}</span>
                    <span>页</span>
	                <span>转到</span>
	                <input type="text" id="page" name="page" class="input pageInput" value="${current}" />
	                <span>页</span>
	                <input type="button" class="btn blue" value="GO" onclick="pageGoto('','${sortType}','${searchParams}','${page.totalPages}','${orderField}','${orderSort}')"/>
            	</li>
         </ul>
     </div>
 </div>
