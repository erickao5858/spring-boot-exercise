<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<html>
<head>
<title>Library</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col">
				<div class="input-group mb-3">
					<span class="input-group-text" id="basic-addon1">Filter</span> <input
						type="text" class="form-control" placeholder="Author Name"
						oninput="applyfilter(this)">
				</div>
			</div>
			<div class="col">
				<div class="dropdown">
					<button class="btn btn-secondary dropdown-toggle" type="button"
						id="dropdownMenuButton1" data-bs-toggle="dropdown"
						aria-expanded="false">Sort</button>
					<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
						<li onclick="sortBooks(0)"><a class="dropdown-item" href="#">Author
								Name (A-Z)</a></li>
						<li onclick="sortBooks(1)"><a class="dropdown-item" href="#">Book
								Name (A-Z)</a></li>
						<li onclick="sortBooks(2)"><a class="dropdown-item" href="#">Price
								($-$$$)</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<table class="table">
		<thead>
			<tr>
				<th scope="col">Book ID</th>
				<th scope="col">Book Name</th>
				<th scope="col">Author</th>
				<th scope="col">Price</th>
				<th scope="col">Actions</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>

	<button type="button" class="btn btn-primary"
		onclick="document.location='addBook'">Add a book</button>

	<form:form id="deleteForm" method="delete">
		<input type="submit" id="deleteFormSubmit" style="visibility: hidden" />
	</form:form>
</body>
</html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.2/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
	integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13"
	crossorigin="anonymous"></script>
<script>
	let books = []
	let filterCriteria = ''
	let sortCriteria = 0
	$(()=>{
		$.get('books',(result)=>{
			// No books
			if(result.length==0){
				return
			}
			books = result
			listBooks()
		})
	})
	listBooks=()=>{
		$('tbody').empty()
		
		switch(sortCriteria){
			case 0: books.sort((a,b)=>{
				if(a.author.toLowerCase()>b.author.toLowerCase()) return 1;
				else return -1;
			})
			break;
			case 1: books.sort((a,b)=>{
				if(a.bookName.toLowerCase()>b.bookName.toLowerCase()) return 1;
				else return -1;
			})
			break;
			case 2: books.sort((a,b)=>{
				if(a.price>b.price) return 1;
				else return -1;
			})
			break;
		}
		books.forEach(book=>{
			
			if(filterCriteria!=''){
				if(!book.author.toLowerCase().includes(filterCriteria.toLowerCase()))
					return
			}
			
			// Append book data
			let tr=$('<tr>')
			tr.append('<th scope="row">'+book.bookId+'</th><td>'+book.bookName+'</td><td>'+book.author+'</td><td>'+book.price+'</td>')
			$('tbody').append(tr)
			
			// Append book actions
			let td=$('<td>')
			
			let buttonEdit=$('<button>')
			buttonEdit.text('Edit')
			buttonEdit.addClass('btn btn-info').attr('type','button')
			buttonEdit.on('click',()=>{
				document.location='editBook/'+book.bookId
			})
			td.append(buttonEdit)
			
			let buttonDelete=$('<button>')
			buttonDelete.text('Delete')
			buttonDelete.addClass('btn btn-danger').attr('type','button')
			buttonDelete.on('click',()=>{
				$('#deleteForm').attr('action','/deleteBook/'+book.bookId)
				$('#deleteFormSubmit').click()
			})
			
			td.append(buttonDelete)
			tr.append(td)
		})
	}
	applyfilter=(e)=>{
		filterCriteria = e.value
		listBooks()
	}
	sortBooks=(criteria)=>{
		sortCriteria=criteria
		listBooks()
	}
</script>