package cn.omsfuk.discount.test.cn.omsfuk.discount.controller.anonymous.test;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultMatcher;
import org.springframework.web.context.WebApplicationContext;

import static com.sun.org.apache.xerces.internal.util.PropertyState.is;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup;

/**
 * Created by omsfuk on 2017/7/23.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class AuthControllerTest {

    @Autowired
    private WebApplicationContext wac;

    private MockMvc mockMvc;

    @Before
    public void before() {
        this.mockMvc = webAppContextSetup(this.wac).build();
    }

    @Test
    public void signIn() {
        try {
            mockMvc.perform((post("/api/anonymous/signIn")).param("phone", "110").param("password", "admin"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.status").value("200"))
                    .andExpect(jsonPath("$.data.id").isNotEmpty())
                    .andDo(print());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void signUp() {

    }


}
