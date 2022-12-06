package com.ratethis.profileservice.repository;

import com.ratethis.profileservice.entity.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    @Query(value = "CALL rate_this_db.is_unique_nick(:nick)", nativeQuery = true)
    Byte isUniqueNickname(@Param("nick") String nick);

    @Query(value = "CALL rate_this_db.is_unique_mail(:mail)", nativeQuery = true)
    Byte isUniqueMail(@Param("mail") String mail);

    User findFirstByNickname(String nick);
    List<User> findByNicknameOrEmail(String nickname, String email);

    @Modifying
    @Query(value = "CALL rate_this_db.user_deliter(:id)", nativeQuery = true)
    void remove(@Param("id") int id);

}