/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.io.Serializable;
import modelo.Editora;

/**
 *
 * @author Luan
 */
   public class EditoraDAO extends GenericDAO<Editora, String>{
    
    public EditoraDAO()
    {
        super(Editora.class);
    }
        
    
}
