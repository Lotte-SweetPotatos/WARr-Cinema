package member;

import dao.MemberDao;
import net.sf.json.JSONObject;

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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        final Optional<String> queryParam = Optional.ofNullable(req.getParameter("param"));
        if (queryParam.isEmpty()) {
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
            resp.getWriter().println(jsonObject);
        }
    }
}
