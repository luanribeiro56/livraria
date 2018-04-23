
<%@page import="util.StormData"%>
<%@page import="modelo.Editora"%>
<%@page import="dao.EditoraDAO"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Categoria"%>
<%@page import="dao.CategoriaDAO"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="modelo.Livro"%>
<%@page import="dao.LivroDAO"%>
<%@include file="../cabecalho.jsp" %>
<%
String msg ="";
String classe = "";
    
    LivroDAO dao = new LivroDAO();
    Livro obj = new Livro();
    
    
    CategoriaDAO cdao = new CategoriaDAO();
    List<Categoria> clistar = cdao.listar();
    Categoria c = new Categoria();

    EditoraDAO edao = new EditoraDAO();
    List<Editora> elistar = edao.listar();
    Editora e = new Editora();
    
    //verifica se � postm ou seja, quer alterar
    if(request.getMethod().equals("POST")){
        
        //popular com oq ele digitou no form
        obj.setId(Integer.parseInt(request.getParameter("txtID")));
        obj.setNome(request.getParameter("txtNome"));
        obj.setPreco(Float.parseFloat(request.getParameter("txtPreco")));
        obj.setDataPublicacao(StormData.formata(request.getParameter("txtData")));
        obj.setSinopse(request.getParameter("txtSinopse"));
        c.setId(Integer.parseInt(request.getParameter("txtCategoria")));
        e.setCnpj(request.getParameter("txtEditora"));
        obj.setCategoria(c);
        obj.setEditora(e);
        obj.setImg1(request.getParameter("txtFoto"));
        obj.setImg2(request.getParameter("txtFoto2"));
        obj.setImg3(request.getParameter("txtFoto3"));
        Boolean resultado = dao.alterar(obj);
        
        if(resultado){
            msg = "Registro alterado com sucesso";
            classe = "alert-success";
        }
        else{
            msg = "N�o foi poss�vel alterar";
            classe = "alert-danger";
        }
        
    }else{
        //e GET
        if(request.getParameter("Id") == null){
            response.sendRedirect("index.jsp");
            return;
        }
        
        dao = new LivroDAO();
        obj = dao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("Id")));
        
        if(obj == null){
            response.sendRedirect("index.jsp");
            return;
        } 
    }
%>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
            Sistema de Com�rcio Eletr�nico
            <small>Admin</small>
        </h1>
        <ol class="breadcrumb">
            <li>
                <i class="fa fa-dashboard"></i>  <a href="index.jsp">�rea Administrativa</a>
            </li>
            <li class="active">
                <i class="fa fa-file"></i> Aqui vai o conte�do de apresenta��o
            </li>
        </ol>
    </div>
</div>
<!-- /.row -->
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
            Livro
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>">
                <%=msg%>
            </div>
            <form action="../UploadWS" method="post" enctype="multipart/form-data">

                <div class="col-lg-6">
                    <div class="form-group">
                        <label>C�digo</label>
                        <input class="form-control" type="text" name="txtID" readonly value="<%=obj.getId()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Nome</label>
                        <input class="form-control" type="text"  name="txtNome"  required />
                    </div>
                    <div class="form-group">
                        <label>Preco: </label>
                        <input class="form-control" type="text"  name="txtPreco"  required />
                    </div>
                    <div class="form-group">
                        <label>Data de Publica��o: </label>
                        <input class="form-control" type="text"  name="txtData"  required />
                    </div>
                    <div class="form-group">
                        <label>Sinopse: </label>
                        <input class="form-control" type="text"  name="txtSinopse"  required />
                    </div>
                    <div class="form-group">
                        <label> Categoria: </label>
                        <select name="txtCategoria"  required />
                        <%
                           for (Categoria item : clistar) {
                               
                         %>
                         <option value = "<%=item.getId()%>">
                             <%=item.getNome()%>
                         </option>
                         <%
                             }
                         %>
                        </select>
                    </div>
                             <div class="form-group">
                        <label> Editora: </label>
                        <select name="txtEditora"  required />
                        <%
                           for (Editora item : elistar) {
                               
                         %>
                         <option value = "<%=item.getCnpj()%>">
                             <%=item.getNome()%>
                         </option>
                         <%
                             }
                         %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Foto: </label>
                        <input class="form-control" type="file"  name="txtFoto"  required />
                    </div>
                    <div class="form-group">
                        <label>Foto 2: </label>
                        <input class="form-control" type="file"  name="txtFoto2"  required />
                    </div>
                    <div class="form-group">
                        <label>Foto 3: </label>
                        <input class="form-control" type="file"  name="txtFoto3"  required />
                    </div>


                <button class="btn btn-primary btn-sm" type="submit">Salvar</button>
                
            </form>

        </div>


    </div>
</div>
<!-- /.row -->
<%@include file="../rodape.jsp" %>