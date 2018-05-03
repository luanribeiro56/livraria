
<%@page import="java.util.ArrayList"%>
<%@page import="dao.AutorDAO"%>
<%@page import="modelo.Autor"%>
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
    
    AutorDAO adao = new AutorDAO();
    List<Autor> alistar = adao.listar();
    
    //verifica se é postm ou seja, quer alterar
   if(request.getMethod().equals("POST")){
        //pego uma lista de autores(com mesmo name)
        String[] autoresid = request.getParameter("autores").split(";");
        //popular o livro
        if (request.getParameter("txtNome") != null && request.getParameter("txtPreco") != null && request.getParameter("txtData") != null && request.getParameter("txtCategoria") != null && request.getParameter("txtEditora") != null) 
            obj.setId(Integer.parseInt(request.getParameter("txtID")));
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
            List<Autor> listaautores = new ArrayList<>();
            for (String id : autoresid) {
                Integer idinteger = Integer.parseInt(id);
                listaautores.add(adao.buscarPorChavePrimaria(idinteger));
            }
            obj.setAutorList(listaautores);
            Boolean resultado = dao.alterar(obj);
            if(resultado){
            msg = "Registro alterado com sucesso";
            classe = "alert-success";
            }
    else{
        msg = "Não foi possível alterar";
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
            Livro
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>">
                <%=msg%>
            </div>
            <form action="../UploadWS" method="post" enctype="multipart/form-data">

                <div class="col-lg-6">
                    <div class="form-group">
                        <label>Código</label>
                        <input class="form-control" type="text" name="txtID" readonly value="<%=obj.getId()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Nome</label>
                        <input class="form-control" type="text"  name="txtNome"  required value="<%=obj.getNome()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Preco: </label>
                        <input class="form-control" type="text"  name="txtPreco"  required value="<%=obj.getPreco()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Data de Publicação: </label>
                        <input class="form-control" type="text"  name="txtData"  required value="<%=obj.getDatapublicacao()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Sinopse: </label>
                        <input class="form-control" type="text"  name="txtSinopse"  required value="<%=obj.getSinopse()%>"/>
                    </div>
                    <div class="form-group">
                        <label> Categoria: </label>
                        <select name="txtCategoria"  required >
                        
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
                        <select name="txtEditora"  required>
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
                        </div>
                        <div class="form-group">
                        <label> Autores: </label>
                        <%
                           for (Autor item : alistar) {
                               
                         %>
                         <input type="checkbox" name="autores"  required value = "<%=item.getId()%>"><%=item.getNome()%>
                         <%}%>
                    </div>
                    <div class="form-group">
                        <label>Foto: </label>
                        <input class="" type="file"  name="txtFoto"  required value="<%=obj.getFoto1()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Foto 2: </label>
                        <input class="" type="file"  name="txtFoto2"  required value="<%=obj.getFoto2()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Foto 3: </label>
                        <input class="" type="file"  name="txtFoto3"  required value="<%=obj.getFoto3()%>"/>
                    </div>


                <button class="btn btn-primary btn-sm" type="submit">Salvar</button>
                
            </form>

        </div>


    </div>
</div>
<!-- /.row -->
<%@include file="../rodape.jsp" %>