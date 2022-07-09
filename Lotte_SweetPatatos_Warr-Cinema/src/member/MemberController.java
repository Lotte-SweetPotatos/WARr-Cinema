package member;

import dao.MemberDao;
import dto.MemberDto;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/member")
public class MemberController extends HttpServlet {

    private final MemberDao memberDao = MemberDao.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final Optional<String> queryParam = Optional.ofNullable(req.getParameter("param"));
        if (isPresentParameter(queryParam)) {
            resp.sendRedirect("movie/main.jsp");
            return;
        }

        final String param = queryParam.get();

        if ("idcheck".equals(param)) {
            final String userId = req.getParameter("userId");
            final boolean userExists = memberDao.findBy(userId);

            final JSONObject jsonObject = new JSONObject();
            jsonObject.put("userExists", userExists);

            resp.setContentType("application/x-json; charset=utf-8");
            return;
        }

        if ("login".equals(param)) {
            resp.sendRedirect("member/login.jsp");
        }
    }

    private boolean isPresentParameter(Optional<String> queryParam) {
        return queryParam.isEmpty() || "".equals(queryParam.get());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final Optional<String> queryParam = Optional.ofNullable(req.getParameter("param"));
        if (isPresentParameter(queryParam)) {
            resp.sendRedirect("movie/main.jsp");
            return;
        }

        final String param = queryParam.get();

        if ("login".equals(param)) {
            resp.setContentType("application/x-json; charset=utf-8");
            final JSONObject jsonObject = new JSONObject();
            jsonObject.put("loginSuccess", login(req));
            resp.getWriter().println(jsonObject);
        }

        if ("signup".equals(param)) {
            String userId = req.getParameter("userId");
            String password = req.getParameter("password");
            String username = req.getParameter("userName");
            String email = req.getParameter("email");
            memberDao.save(new MemberDto(userId, password, username, email));
        }
    }

    private boolean login(HttpServletRequest req) {
        final Optional<String> queryUserId = Optional.ofNullable(req.getParameter("userId"));
        final Optional<String> queryPassword = Optional.ofNullable(req.getParameter("password"));

        if (isPresentParameter(queryUserId) || isPresentParameter(queryPassword)) {
            return false;
        }

        final String userId = queryUserId.get();
        final String password = queryPassword.get();
        final Optional<MemberDto> foundMemberDto = memberDao.findBy(userId, password);

        if (foundMemberDto.isEmpty()) {
            return false;
        }

        req.getSession().setAttribute("member", foundMemberDto.get());
        return true;
    }
}
