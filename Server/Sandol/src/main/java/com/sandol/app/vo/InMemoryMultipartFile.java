package com.sandol.app.vo;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;

import org.springframework.web.multipart.MultipartFile;

public class InMemoryMultipartFile implements MultipartFile {

    private final String name;
    private final byte[] content;
    private transient InputStream inputStream;

    public InMemoryMultipartFile(String name, byte[] content) {
        this.name = name;
        this.content = content;
        this.inputStream = new ByteArrayInputStream(content);
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public String getOriginalFilename() {
        return name;
    }

    @Override
    public String getContentType() {
        // 예제에서는 간단하게 생략
        return null;
    }

    @Override
    public boolean isEmpty() {
        return content.length == 0;
    }

    @Override
    public long getSize() {
        return content.length;
    }

    @Override
    public byte[] getBytes() throws IOException {
        return content;
    }

    @Override
    public InputStream getInputStream() throws IOException {
        return new ByteArrayInputStream(content);
    }

    @Override
    public void transferTo(java.io.File dest) throws IOException, IllegalStateException {
        Files.write(dest.toPath(), content);
    }
}