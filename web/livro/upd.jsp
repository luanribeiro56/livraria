
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
String selecionado;
    
    LivroDAO dao = new LivroDAO();
    Livro obj = new Livro();
    
    
    CategoriaDAO cdao = new CategoriaDAO();
    Categoria c = new Categoria();

    EditoraDAO edao = new EditoraDAO();
    Editora e = new Editora();
    
    AutorDAO adao = new AutorDAO();
    
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
            obj.setFoto1(request.getParameter("txtFoto1"));
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
    }
    else{
        //e GET
        if(request.getParameter("id") == null){
            response.sendRedirect("index.jsp");
            return;
        }
        
        
        obj = dao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("Id")));
        
        if(obj == null){
            response.sendRedirect("index.jsp");
            return;
        } 
    }
   
    List<Autor> autores = adao.listar();
    List<Editora> editoras = edao.listar();
    List<Categoria> categorias = cdao.listar();
    
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
                        <input class="form-control" type="text"  name="txtData"  required value="<%=StormData.formata(obj.getDatapublicacao())%>"/>
                    </div>
                    <div class="form-group">
                        <label>Sinopse: </label>
                        <textarea class="form-control" name="txtSinopse"><%=obj.getSinopse()%>"/></textarea>
                    </div> 
                    <div class="form-group">
                        <label> Categoria: </label>
                        <select name="txtCategoria"  required >
                        
                        <% 
                            for (Categoria item : categorias) {
                             
                                if (obj.getCategoria().getId() == item.getId()) 
                                {
                                    selecionado = "selected";
                                }
                                else
                                {
                                    selecionado = "";
                                }
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
                           for (Editora item : editoras) {
                              
                               if(obj.getEditora().getCnpj() == item.getCnpj())
                               {
                                   selecionado = "selected";
                               }
                               else
                               {
                                   selecionado = "";
                               }
                                   
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
                           for (Autor item : autores) {
                               
                               if(obj.getAutorList().contains(item))
                               {
                                   selecionado = "checked";
                               }
                               else
                               {
                                   selecionado = "";
                               }
                         %>
                         <input type="checkbox" name="autores"  required value = "<%=item.getId()%>"><%=item.getNome()%>
                         <%}%>
                    </div>
                    <div class="form-group">
                        <label>Foto: </label>
                        <input class="" type="file"  name="txtFoto1" id="txtFoto1"  accept="image/*"/>
                        <img src="../arquivos/<%=obj.getFoto1()%>" id="img1"/>
                    </div>
                    <div class="form-group">
                        <label>Foto 2: </label>
                        <input class="" type="file"  name="txtFoto2" id="txtFoto2"  accept="image/*"/>
                        <img src="../arquivos/<%=obj.getFoto2()%>" id="img2"/>
                    </div>
                    <div class="form-group">
                        <label>Foto 3: </label>
                        <input class="" type="file"  name="txtFoto3" id="txtFoto3"  accept="image/*"/>
                        <img src="../arquivos/<%=obj.getFoto3()%>" id="img3"/>
                    </div>


                <button class="btn btn-primary btn-sm" type="submit">Salvar</button>
                
            </form>

        </div>


    </div>
</div>
<!-- /.row -->
<%@include file="../rodape.jsp" %>
<script>
    function readURL(input,destino) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
                $('#'+destino).attr('src', e.target.result);
            }
            
            reader.readAsDataURL(input.files[0]);
        }
    }
    
    $("#arquivo1").change(function(){
        readURL(this,"img1");
    });
    $("#arquivo2").change(function(){
        readURL(this,"img2");
    });
    $("#arquivo3").change(function(){
        readURL(this,"img3");
    });
</script>