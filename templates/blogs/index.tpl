{{ define "blogs/index.tpl"}}
    {{ template "layouts/header.tpl" .}}

        {{if .page}}
        <script>
            function generatePaginationLinks(link, currentPage, totalPages, pageSize) {
                let paginationHTML = '';

                if (totalPages > 1) {
                    paginationHTML += '<div class="pagination">';

                    if (currentPage > 1) {
                        paginationHTML += `<a href="${link}?page=${currentPage - 1}&pageSize=${pageSize}">Previous</a>`;
                    }

                    for (let page = 1; page <= totalPages; page++) {
                        if (page === currentPage) {
                            paginationHTML += `<span class="current-page">${page}</span>`;
                        } else {
                            paginationHTML += `<a href="${link}?page=${page}&pageSize=${pageSize}">${page}</a>`;
                        }
                    }

                    if (currentPage < totalPages) {
                        paginationHTML += `<a href="${link}?page=${currentPage + 1}&pageSize=${pageSize}">Next</a>`;
                    }

                    paginationHTML += '</div>';
                }

                return paginationHTML;
            }

            window.onload = function() {
                const paginationLinks = generatePaginationLinks("/blogs", {{.page}}, {{.totalPages}}, {{.pageSize}});

                const contentDiv = document.getElementById('pagination');
                contentDiv.innerHTML = paginationLinks;
            };
        </script>
        {{end}}

        <div>
            <h1>Blogs</h1>

            <div id="pagination" class="pagination">
            </div>

            <br/>
            <br/>

            <ul>
                {{ with .blogs }}
                    {{ range . }}
                        <li>
                            <div>
                                <a href="/blogs/{{.ID}}">
                                    <h5>{{ .Title }} </h5>
                                </a>
                                <p>{{ .Content }}</p>
                            </div>
                            <br/>
                        </li>
                    {{ end }}
                {{ end }}
            </ul>
        </div>
    {{ template "layouts/footer.tpl" .}}
{{end}}