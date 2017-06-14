<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                <ul class="list-inline text-center">
                    <li>
                        <a target="_blank" href="mailto:${requestScope.admin.email}">
                            <span class="fa-stack fa-lg">
                                <i class="fa fa-circle fa-stack-2x"></i>
                        <i class="fa fa-envelope-o fa-stack-1x fa-inverse"></i>
                            </span>
                        </a>
                    </li>
                    <li>
                        <a target="_blank" href="${requestScope.admin.github}">
                            <span class="fa-stack fa-lg">
                                <i class="fa fa-circle fa-stack-2x"></i>
                                <i class="fa fa-github fa-stack-1x fa-inverse"></i>
                            </span>
                        </a>
                    </li>


                </ul>
                <p class="copyright text-muted">
                    Copyright &copy; 2017 by iblog deveploer
                    <br>
                </p>
            </div>
        </div>
    </div>
</footer>