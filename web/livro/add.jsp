<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Autor"%>
<%@page import="dao.AutorDAO"%>
<%@page import="dao.EditoraDAO"%>
<%@page import="modelo.Editora"%>
<%@page import="dao.CategoriaDAO"%>
<%@page import="dao.CategoriaDAO"%>
<%@page import="modelo.Categoria"%>
<%@page import="util.StormData"%>
'<%@page import="java.math.BigDecimal"%>
<%@page import="dao. LivroDAO"%>
<%@page import="modelo. Livro"%>
<%@page import="java.util.List"%>

<%@include file="../cabecalho.jsp" %>
<%
    String msg = "";
    String classe = "";
    
     Livro obj = new  Livro();
     LivroDAO dao = new  LivroDAO();
  
     CategoriaDAO cdao = new CategoriaDAO();
     List<Categoria> clistar = cdao.listar();
     Categoria c = new Categoria();
     
     EditoraDAO edao = new EditoraDAO();
     List<Editora> elistar = edao.listar();
     Editora e = new Editora();
     
    AutorDAO adao = new AutorDAO();
     
    if(request.getMethod().equals("POST")){
        //pego uma lista de autores(com mesmo name)
        String[] autoresid = request.getParameterValues("autores");
        //popular o livro
        if (request.getParameter("txtNome") != null && request.getParameter("txtPreco") != null && request.getParameter("txtData") != null && request.getParameter("txtCategoria") != null && request.getParameter("txtEditora") != null) 
        {
            obj.setNome(request.getParameter("txtNome"));
            obj.setPreco(Float.parseFloat(request.getParameter("txtPreco")));
            obj.setDatapublicacao(StormData.formata(request.getParameter("txtData")));
            obj.setSinopse(request.getParameter("txtSinopse"));
            c.setId(Integer.parseInt(request.getParameter("txtCategoria")));
            e.setCnpj(request.getParameter("txtEditora"));
            obj.setCategoria(c);
            obj.setEditora(e);
            obj.setFoto1(request.getParameter("txtFoto"));
            obj.setFoto2(request.getParameter("txtFoto2"));
            obj.setFoto3(request.getParameter("txtFoto3"));
            //Autores
            List<Autor> listaautores = new ArrayList<>();
            for (String id : autoresid) {
                Integer idinteger = Integer.parseInt(id);
                listaautores.add(adao.buscarPorChavePrimaria(idinteger));
            }
            obj.setAutorList(listaautores);
            Boolean resultado = dao.incluir(obj);
            if (resultado) {
                msg = "Registro cadastrado com sucesso";
                classe = "alert-success";
            } else {
                msg = "Não foi possível cadastrar";
                classe = "alert-danger";
            }
        }
     
     
     
     
    dao.fecharConexao();
    

%>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
            Sistema de Comércio Eletrônico
            <small>Admin</small>
        </h1>
        <ol class="breadcrumb">
            <li>
                <i class="fa fa-dashboard"></i>  <a href="index.jsp">Área Administrativa</a>
            </li>
            <li class="active">
                <i class="fa fa-file"></i> Aqui vai o conteúdo de apresentação 
            </li>
        </ol>
    </div>
</div>
<!-- /.row -->
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
             Livros
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>">
                <%=msg%>
            </div>
            <form action="../UploadWS" method="post" enctype="multipart/form-data">

                <div class="col-lg-6">

                    <div class="form-group">
                        <label>Nome</label>
                        <input class="form-control" type="text"  name="txtNome"  required />
                    </div>
                    <div class="form-group">
                        <label>Preco: </label>
                        <input class="form-control" type="text"  name="txtPreco"  required />
                    </div>
                    <div class="form-group">
                        <label>Data de Publicação: </label>
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
<!-- 1/.row -->
<%@include file="../rodape.jsp" %>