<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Add Book</title>
</head>
<body>
	<c:if test="${addBookSuccess}">
		<div>Successfully added Book with ID: ${savedBook.bookId}</div>
	</c:if>

	<c:url var="add_book_url" value="/addBook" />
	<form:form action="${add_book_url}" method="post" modelAttribute="book">
		<div>
			<form:label path="bookId">Book ID: </form:label>
			<form:input type="text" path="bookId" />
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
			<input type="submit" value="submit" />
		</div>
	</form:form>
	<button onclick="document.location='/'">Back</button>
</body>
</html>