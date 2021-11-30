package com.task.entity;

import com.sun.xml.internal.ws.api.ha.StickyFeature;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.swing.plaf.synth.SynthTextAreaUI;
import java.util.Arrays;

/**
 * @author: hbw
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Book {
    private int id;
    private String name;
    private int price;
    private byte[] photo;
    private String imag;
    private String introduction;
    private String authorName;
    private String publish;
    private String publishDate;
    private int sort;
    private int countPublish;

    public Book(int id, String name, int price, byte[] photo,int sort) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.photo = photo;
        this.sort = sort;
    }

    public Book(int id, String name, int price, byte[] photo) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.photo = photo;
    }

    public Book(int id,String name,int price,String introduction){
        this.id = id;
        this.name = name;
        this.price = price;
        this.introduction = introduction;
    }

    public Book(String name, int price) {
        this.id = 0;
        this.name = name;
        this.price = price;
    }

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", photo=" + Arrays.toString(photo) +
                ", imag='" + imag + '\'' +
                ", introduction='" + introduction + '\'' +
                ", authorName='" + authorName + '\'' +
                ", publish='" + publish + '\'' +
                ", publishDate='" + publishDate + '\'' +
                ", sort='" + sort + '\'' +
                '}';
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public void setPhoto(byte[] photo) {
        this.photo = photo;
    }

    public void setImag(String imag) {
        this.imag = imag;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public void setPublish(String publish) {
        this.publish = publish;
    }

    public void setPublishDate(String publishDate) {
        this.publishDate = publishDate;
    }

    public void setSort(int sort) {
        this.sort = sort;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getPrice() {
        return price;
    }

    public byte[] getPhoto() {
        return photo;
    }

    public String getImag() {
        return imag;
    }

    public String getIntroduction() {
        return introduction;
    }

    public String getAuthorName() {
        return authorName;
    }

    public String getPublish() {
        return publish;
    }

    public String getPublishDate() {
        return publishDate;
    }

    public int getSort() {
        return sort;
    }
}
