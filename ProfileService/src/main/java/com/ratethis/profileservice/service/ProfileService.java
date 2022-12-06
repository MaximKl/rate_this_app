package com.ratethis.profileservice.service;
import com.ratethis.profileservice.entity.user.User;
import com.ratethis.profileservice.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProfileService {
    @Autowired
    private UserRepository userRepository;

    public User saveUser(User user){
        return userRepository.save(user);
    }

    public boolean uniqueNickname(String nick){
        return 1 == userRepository.isUniqueNickname(nick);
    }

    public boolean uniqueMail(String mail){
        return 1 == userRepository.isUniqueMail(mail);
    }

    public User authorisation(String name, String password){
        return userRepository.findByNicknameOrEmail(name, name).stream().filter(u->u.getPassword().equals(password)).findFirst().orElseGet(User::new);
    }

    public User getUserByNick(String nick){
        return userRepository.findFirstByNickname(nick);
    }

    public User getUserById(int id){
        return userRepository.findById(id).orElseGet(User::new);
    }

    @Transactional
    public void removeUser(int id){
        userRepository.remove(id);
    }
}