// 提供者：TinyMirror
#include <iostream>
#include <vector>
using namespace std;
const int maxn = 1e6 + 5;
int a[maxn], len = 0, ans = 1;
vector<int> b[maxn];
int search(int x, int l, int r) {
	int res = r + 1;
	while (l <= r) {
		int mid = (l + r) >> 1;
		if (*(b[mid].end() - 1) > x) {
			res = mid;
			r = mid - 1;
		} else {
			l = mid + 1;
		}
	}
	return res;
}
int main() {
	int n; cin >> n;
	for (int i = 1; i <= n; i++) {
		cin >> a[i];
		int pos = search(a[i], 1, len);
		b[len = pos].push_back(a[i]);
		ans = max(ans, len);
		
	}
	for (int i = 1; i <= ans; i++) {
		for (int j = 0; j < (int)b[i].size(); j++) {
			cout << b[i][j] << " ";
		}
		cout << '\n';
	}
	cout << '\n' << ans;
	return 0;
}
