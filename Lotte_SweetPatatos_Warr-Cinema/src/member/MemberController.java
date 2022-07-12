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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        final Optional<String> queryParam = Optional.ofNullable(req.getParameter("param"));
        if (isPresentParameter(queryParam)) {
            resp.sendRedirect("movie/main.jsp");
            return;
        }

        final String param = queryParam.get();

        if ("idcheck".equals(param)) {
            final String userId = req.getParameter("userId");
            final boolean userExists = memberDao.findBy(userId);

            resp.setContentType("application/x-json; charset=utf-8");
            final JSONObject jsonObject = new JSONObject();
            jsonObject.put("userExists", userExists);
            resp.getWriter().println(jsonObject);
            return;
        }

        if ("login".equals(param)) {
            resp.sendRedirect("member/login.jsp");
            return;
        }

        if ("signup".equals(param)) {
            resp.sendRedirect("member/signup.jsp");
        }

        if ("mypage".equals(param)) {
            int memberId = Integer.parseInt(req.getParameter("memberId"));
            JSONObject jsonob = memberDao.findByReserve(memberId);
            req.setAttribute("reserve", jsonob);
            req.getRequestDispatcher("member/mypage.jsp").forward(req, resp);
        }
    }

    private boolean isPresentParameter(Optional<String> queryParam) {
        return queryParam.isEmpty() || "".equals(queryParam.get());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        final Optional<String> queryParam = Optional.ofNullable(req.getParameter("param"));
        if (isPresentParameter(queryParam)) {
            resp.sendRedirect("movie/main.jsp");
            return;
        }

        final String param = queryParam.get();

        resp.setContentType("application/x-json; charset=utf-8");
        final JSONObject jsonObject = new JSONObject();

        if ("login".equals(param)) {
            jsonObject.put("loginSuccess", login(req));
            resp.getWriter().println(jsonObject);
            return;
        }

        if ("signup".equals(param)) {
            jsonObject.put("signupSuccess", signup(req));
            resp.getWriter().println(jsonObject);
            return;
        }

        if ("cancel".equals(param)) {
            int userId = Integer.parseInt(req.getParameter("memberId"));
            int movieId = Integer.parseInt(req.getParameter("movieId"));
            int runningId = Integer.parseInt(req.getParameter("runningId"));
            boolean cancelSuccess = memberDao.cancelReserve(userId, movieId, runningId);

            jsonObject.put("cancelSuccess", cancelSuccess);
            resp.getWriter().println(jsonObject);
         }
    }

    private boolean signup(HttpServletRequest req) {
        final Optional<String> queryUserId = Optional.ofNullable(req.getParameter("userId"));
        final Optional<String> queryPassword = Optional.ofNullable(req.getParameter("password"));
        final Optional<String> queryName = Optional.ofNullable(req.getParameter("userName"));
        final Optional<String> queryEmail = Optional.ofNullable(req.getParameter("email"));

        if (isPresentParameter(queryUserId) || isPresentParameter(queryPassword)
                || isPresentParameter(queryName) || isPresentParameter(queryEmail)) {
            return false;
        }

        final String userId = queryUserId.get();
        final String password = queryPassword.get();
        final String userName = queryName.get();
        final String email = queryEmail.get();

        return memberDao.save(new MemberDto(userId, userName, password, email));
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
