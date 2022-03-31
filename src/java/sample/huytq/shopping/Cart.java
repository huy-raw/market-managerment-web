/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.huytq.shopping;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author HuyRaw
 */
public class Cart {
    private Map<String, Product> cart;

    public Cart() {
    }

    public Cart(Map<String, Product> cart) {
        this.cart = cart;
    }

    public Map<String, Product> getCart() {
        return cart;
    }

    public void setCart(Map<String, Product> cart) {
        this.cart = cart;
    }
    
    public void add(Product product){
        if(this.cart == null){
            this.cart = new HashMap<>();
        }
        if(this.cart.containsKey(product.getProductID())) {
            int currentQuantity = this.cart.get(product.getProductID()).getQuantity();
            product.setQuantity(currentQuantity + product.getQuantity());
        }
        cart.put(product.getProductID(), product);
    }
    
    public void delete(String id) {
        if (this.cart == null) {
            return;
        }
        if (this.cart.containsKey(id)) {
            this.cart.remove(id);
        }

    }
    
    public int getCartAmountProduct(){
        int amount = 0;
        for (Product product: this.cart.values()){
            amount+= product.getQuantity();
        }
        return amount;
    }
    
    public double getCartTotalPrice() {
        double total = 0;
        for (Product product : this.cart.values()) {
            total += (product.getPrice()*product.getQuantity());
        }
        return  total;
    }
    
    public void update(Product newProduct) {
        if (this.cart==null) return;
        if(this.cart.containsKey(newProduct.getProductID())){
            this.cart.replace(newProduct.getProductID(), newProduct);
        }
    }
}
