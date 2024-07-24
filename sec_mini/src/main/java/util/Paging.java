package util;

public class Paging {
    public static String getPaging(String pageURL, int nowPage, int rowTotal, int blockList, int blockPage) {
        int totalPage, startPage, endPage;
        boolean isPrevPage, isNextPage;
        StringBuffer sb;

        isPrevPage = isNextPage = false;
        totalPage = rowTotal / blockList;
        if (rowTotal % blockList != 0) totalPage++;

        if (nowPage > totalPage) nowPage = totalPage;

        startPage = ((nowPage - 1) / blockPage) * blockPage + 1;
        endPage = startPage + blockPage - 1;

        if (endPage > totalPage) endPage = totalPage;
        if (endPage < totalPage) isNextPage = true;
        if (startPage > 1) isPrevPage = true;

        sb = new StringBuffer("<ul class='pagination'>");

        if (isPrevPage) {
            sb.append(String.format("<li><a href='%s?page=%d'>◀</a></li>", pageURL, startPage - 1));
        } else {
            sb.append("<li><a href='#'>◀</a></li>");
        }

        for (int i = startPage; i <= endPage; i++) {
            if (i == nowPage) {
                sb.append(String.format("<li class='active'><a href='#'>%d</a></li>", i));
            } else {
                sb.append(String.format("<li><a href='%s?page=%d'>%d</a></li>", pageURL, i, i));
            }
        }

        if (isNextPage) {
            sb.append(String.format("<li><a href='%s?page=%d'>▶</a></li>", pageURL, endPage + 1));
        } else {
            sb.append("<li><a href='#'>▶</a></li>");
        }

        sb.append("</ul>");
        return sb.toString();
    }
}