package com.alkewallet.service;

import com.alkewallet.model.Account;
import com.alkewallet.model.User;

import java.util.HashMap;
import java.util.Map;

public class WalletService {
    private static WalletService instance;
    private final Map<String, User> usersByEmail = new HashMap<>();
    private int nextUserId = 1;

    private WalletService() {
        seedInitialData();
    }

    public static synchronized WalletService getInstance() {
        if (instance == null) {
            instance = new WalletService();
        }
        return instance;
    }

    private void seedInitialData() {
        // Usuario demo oficial basado en el diseño de Figma y requerimientos
        Account account = new Account(1, "AW-0012489", 124.57);
        // Sembrar transacciones del diseño
        account.deposit(9.00, "Depósito de fondos - Hiba Saleh");
        account.withdraw(21.30, "Transferencia enviada - Reem Khaled");
        account.deposit(12.40, "Transferencia recibida - Ahmad Ibrahim");
        account.deposit(20.50, "Depósito de fondos - Sara Ibrahim");
        account.withdraw(15.00, "Transferencia enviada - Yara Khalil");

        User demoUser = new User(nextUserId++, "Amanda Alkemy", "amanda@alkewallet.com", "1234", account);
        usersByEmail.put(demoUser.getEmail().toLowerCase(), demoUser);

        // Usuario secundario de pruebas
        Account accVanne = new Account(2, "AW-0099881", 500.00);
        accVanne.deposit(500.00, "Depósito inicial de bienvenida");
        User vanneUser = new User(nextUserId++, "Vanne Pulgar", "vanne@alkewallet.com", "1234", accVanne);
        usersByEmail.put(vanneUser.getEmail().toLowerCase(), vanneUser);
    }

    public synchronized User authenticate(String email, String password) {
        if (email == null || password == null) {
            return null;
        }
        User user = usersByEmail.get(email.trim().toLowerCase());
        if (user != null && user.getPassword().equals(password.trim())) {
            return user;
        }
        return null;
    }

    public synchronized boolean registerUser(String name, String email, String password) {
        if (email == null || password == null || name == null) {
            return false;
        }
        String cleanEmail = email.trim().toLowerCase();
        if (usersByEmail.containsKey(cleanEmail)) {
            return false; // Usuario ya existe
        }

        Account newAccount = new Account(nextUserId, "AW-00" + (10000 + nextUserId), 0.0);
        User newUser = new User(nextUserId++, name.trim(), cleanEmail, password.trim(), newAccount);
        usersByEmail.put(cleanEmail, newUser);
        return true;
    }

    public synchronized boolean deposit(User user, double amount, String description) {
        if (user == null || user.getAccount() == null) {
            return false;
        }
        return user.getAccount().deposit(amount, description);
    }

    public synchronized boolean withdraw(User user, double amount, String description) {
        if (user == null || user.getAccount() == null) {
            return false;
        }
        return user.getAccount().withdraw(amount, description);
    }

    public synchronized User getUserByEmail(String email) {
        if (email == null) return null;
        return usersByEmail.get(email.trim().toLowerCase());
    }
}
