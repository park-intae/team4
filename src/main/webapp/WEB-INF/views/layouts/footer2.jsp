<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- sidebar용 js 포함, sidebar 있으면 사용 -->
</div>
<footer>
    <div class="copyright">Created By Team Uh!ban</div>
</footer>
<!-- sidebar js -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var menuBtn = document.querySelector('.menu-btn');
        var nav = document.querySelector('nav');
        var searchbar = document.querySelector('.search-bar');
        var b_cat = document.querySelector('.b-cat');
        var link = document.querySelector('.link');
        var s_cat = document.querySelector('.s-cat');

        menuBtn.addEventListener('click', function() {
            nav.classList.toggle('nav-open');
            b_cat.classList.toggle('open');
            if (!b_cat.classList.contains('open')) {
                s_cat.style.display = 'none';
            }
            searchbar.classList.toggle('open');
        });

        link.addEventListener('click', function(e) {
            e.preventDefault();
            s_cat.style.display = s_cat.style.display === 'none' ? 'block'
                    : 'none';
        });

        document.addEventListener('click',
                function(e) {
                    var target = e.target;
                    if (!target.closest('.b_cat')
                            && !target.classList.contains('link')) {
                        s_cat.style.display = 'none';
                    }
                });
    });
</script>
</body>
</html>