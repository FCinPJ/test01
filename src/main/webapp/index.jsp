<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<html>
<body>
	<form action="" method = post name = "form">
		用户名：<input type = text name = "text">
		密码：<input type = password name = "password">
		<input type = submit name = submit value = "确定">
	</form>
	<%
		String text = (String)request.getAttribute("text");
		if(text ==null){
			text = "";
		}
		String password = (String)request.getAttribute("password");
		if(password ==null){
			password = "";
		}
		//JDBC 驱动名及数据库 URL
		final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
		final String DB_URL = "jdbc:mysql://localhost:3306/test1";

		// 数据库的用户名与密码
		final String USER = "root";
		final String PASS = "123456";

		Connection conn = null;
		Statement stmt = null;
		try {
			// 注册 JDBC 驱动
			Class.forName(JDBC_DRIVER);

			// 打开链接
			System.out.println("连接数据库...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);

			// 执行查询
			System.out.println(" 实例化Statement对象...");
			stmt = conn.createStatement();
			String sql;
			sql = "SELECT * FROM logincheck";//sql语句
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
                String username=rs.getString("text");
                String pd=rs.getString("password");
                out.print(text);
                out.print(password);
                if(username.equals(text)&&pd.equals(password)) {
                    out.print("登录成功");
                }else {
                    return;
                }
			}
			// 完成后关闭
			rs.close();
			stmt.close();
			conn.close();
		} catch (SQLException se) {
			// 处理 JDBC 错误
			se.printStackTrace();
		} catch (Exception e) {
			// 处理 Class.forName 错误
			e.printStackTrace();
		} finally {
			// 关闭资源
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException se2) {
			} // 什么都不做
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
	%>
	
</body>
</html>