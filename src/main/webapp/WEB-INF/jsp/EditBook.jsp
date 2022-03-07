<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Edit Book</title>
</head>
<body>
	<c:if test="${editBookSuccess}">
		<div>Successfully edited Book with ID: ${book.bookId}</div>
	</c:if>

	<c:url var="edit_book_url" value="/editBook/${book.bookId}" />
	<form:form action="${edit_book_url}" method="put" modelAttribute="book">
		<div>
			<form:label path="bookId">Book ID: </form:label>
			<form:input type="text" path="bookId" readonly="true" />
		</div>
		<div>
			<form:label path="bookName">Book Name: </form:label>
			<form:input type="text" path="bookName" />
		</div>
		<div>
			<form:label path="author">Author: </form:label>
			<form:input type="text" path="author" />
		</div>
		<div>
			<form:label path="price">Price: </form:label>
			<form:input type="text" path="price" />
		</div>
		<div>
			<input type="submit" value="update" />
		</div>
	</form:form>
	<button onclick="document.location='/'">Back</button>
</body>
</html>