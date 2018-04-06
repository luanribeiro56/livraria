/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.io.Serializable;
import modelo.Livro;

/**
 *
 * @author Luan
 */
public class LivroDAO extends GenericDAO<Livro, Integer> {
    
    public LivroDAO()
    {
        super(Livro.class);
    }
        
}
