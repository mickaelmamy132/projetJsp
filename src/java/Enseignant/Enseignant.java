/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Enseignant;

/**
 *
 * @author Mickael
 */
public class Enseignant {
    private Integer matricule;
    private String nom;
    private Float taux;
    private Float heure;
    private Float prestation; 

//constructeur
 public Enseignant() {
 }
//constructeur avec parametre
 public Enseignant(Integer matricule,String nom,Float taux,Float heure,Float prestation){
 
 this.matricule = matricule;
 this.nom = nom;
 this.taux = taux;
 this.heure = heure;
 this.prestation = prestation;
 }
 
 // Méthodes Getter et Setter
    public Integer getMatricule() {
        return matricule;
    }
     public void setMatricule(Integer matricule) {
        this.matricule = matricule;
    }
    
    public String getNom(){
        return nom;
    }
     public void setNom(String mon) {
        this.nom = nom;
    }
    
    public Float getTaux(){
        return taux;
    }
     public void setTaux(Float taux) {
        this.taux = taux;
    }
    
    public Float getHeure(){
        return heure;
    }
     public void setHeure(Float heure) {
        this.heure = heure;
    }
    
    public Float getPrestation(){
        return prestation;
    }
     public void setPrestation(Float prestation) {
        this.prestation = prestation;
    }     
}
