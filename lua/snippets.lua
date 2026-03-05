local snippets = {
  debug_body = [[
#ifdef LOCAL
#define DEBUG(...) debug(#__VA_ARGS__, __VA_ARGS__)
#else
#define DEBUG(...) 6
#endif

template<typename T, typename S> ostream& operator << (ostream &os, const pair<T, S> &p) {return os << "(" << p.first << ", " << p.second << ")";}
template<typename C, typename T = decay<decltype(*begin(declval<C>()))>, typename enable_if<!is_same<C, string>::value>::type* = nullptr>
ostream& operator << (ostream &os, const C &c) {bool f = true; os << "["; for (const auto &x : c) {if (!f) os << ", "; f = false; os << x;} return os << "]";}
template<typename T> void debug(string s, T x) {cerr << "\033[1;35m" << s << "\033[0;32m = \033[33m" << x << "\033[0m\n";}
template<typename T, typename... Args> void debug(string s, T x, Args... args) {for (int i=0, b=0; i<(int)s.size(); i++) if (s[i] == '(' || s[i] == '{') b++; else
if (s[i] == ')' || s[i] == '}') b--; else if (s[i] == ',' && b == 0) {cerr << "\033[1;35m" << s.substr(0, i) << "\033[0;32m = \033[33m" << x << "\033[31m | "; debug(s.substr(s.find_first_not_of(' ', i + 1)), args...); break;}}]]
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp", "c" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    local function bind_snippet(trigger, body)
      vim.keymap.set("ia", trigger, function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<BS>", true, false, true), "n", true)
        vim.snippet.expand(body)
      end, { buffer = true, desc = "Expand " .. trigger })
    end

    bind_snippet("cptemp", "#include <bits/stdc++.h>\nusing namespace std;\n\n" .. snippets.debug_body .. "\n\nsigned main() {\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    $1\n}")
    bind_snippet("cftemp", "#include <bits/stdc++.h>\nusing namespace std;\n\n" .. snippets.debug_body .. "\n\nvoid solve() {\n    $1\n}\n\nsigned main() {\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    int t; cin >> t;\n    while(t--) {\n        solve();\n    }\n}")
    bind_snippet("debug", snippets.debug_body)
  end,
})
