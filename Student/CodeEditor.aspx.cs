using System;
using System.Web.UI;

namespace PlacementPrep
{
    public partial class CodeEditor : System.Web.UI.Page
    {
        private const string CSharpTemplate = @"public class Solution {
    public int[] TwoSum(int[] nums, int target) {
        var map = new System.Collections.Generic.Dictionary<int, int>();
        for (int i = 0; i < nums.Length; i++) {
            int complement = target - nums[i];
            if (map.ContainsKey(complement)) {
                return new int[] { map[complement], i };
            }
            if (!map.ContainsKey(nums[i])) {
                map.Add(nums[i], i);
            }
        }
        return new int[0];
    }
}";

        private const string CppTemplate = @"#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        unordered_map<int, int> map;
        for (int i = 0; i < nums.size(); ++i) {
            int complement = target - nums[i];
            if (map.find(complement) != map.end()) {
                return {map[complement], i};
            }
            map[nums[i]] = i;
        }
        return {};
    }
};";

        private const string JavaTemplate = @"import java.util.HashMap;
import java.util.Map;

class Solution {
    public int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int comp = target - nums[i];
            if (map.containsKey(comp)) {
                return new int[] { map.get(comp), i };
            }
            map.put(nums[i], i);
        }
        return new int[0];
    }
}";

        private const string PythonTemplate = @"class Solution:
    def twoSum(self, nums: list[int], target: int) -> list[int]:
        seen = {}
        for i, num in enumerate(nums):
            complement = target - num
            if complement in seen:
                return [seen[complement], i]
            seen[num] = i
        return []";

        private const string JsTemplate = @"/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
var twoSum = function(nums, target) {
    const map = new Map();
    for (let i = 0; i < nums.length; i++) {
        const diff = target - nums[i];
        if (map.has(diff)) {
            return [map.get(diff), i];
        }
        map.set(nums[i], i);
    }
    return [];
};";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                if (id == "2")
                {
                    lblEditorProblemTitle.Text = "2. Longest Substring Without Repeating Characters";
                }
                else if (id == "3")
                {
                    lblEditorProblemTitle.Text = "3. Valid Parentheses";
                }

                LoadTemplateForLanguage("csharp");
            }
        }

        private void LoadTemplateForLanguage(string lang)
        {
            switch (lang.ToLower())
            {
                case "cpp":
                    txtCodeArea.Text = CppTemplate;
                    break;
                case "java":
                    txtCodeArea.Text = JavaTemplate;
                    break;
                case "python":
                    txtCodeArea.Text = PythonTemplate;
                    break;
                case "javascript":
                    txtCodeArea.Text = JsTemplate;
                    break;
                case "csharp":
                default:
                    txtCodeArea.Text = CSharpTemplate;
                    break;
            }
        }

        protected void ddlLanguage_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadTemplateForLanguage(ddlLanguage.SelectedValue);
            litConsoleOutput.Text = "<span style=\"color:#94a3b8;\">// Switched environment to " + ddlLanguage.SelectedItem.Text + ". Template reloaded.</span>";
        }

        protected void btnResetCode_Click(object sender, EventArgs e)
        {
            LoadTemplateForLanguage(ddlLanguage.SelectedValue);
            litConsoleOutput.Text = "<span style=\"color:#94a3b8;\">// Code editor reset to initial starter template.</span>";
        }

        protected void btnRunCode_Click(object sender, EventArgs e)
        {
            litConsoleOutput.Text = @"<div style='color:#38bdf8; font-weight:bold; margin-bottom:4px;'>&gt; Running Simulation Test Suite against sample inputs...</div>
<div style='margin-bottom:2px;'><span class='ide-pass-badge'>PASS</span> <span style='color:#f1f5f9;'>Case 1:</span> nums = [2,7,11,15], target = 9 &rarr; Output: <strong>[0, 1]</strong> (Expected: [0, 1]) [14ms]</div>
<div style='margin-bottom:4px;'><span class='ide-pass-badge'>PASS</span> <span style='color:#f1f5f9;'>Case 2:</span> nums = [3,2,4], target = 6 &rarr; Output: <strong>[1, 2]</strong> (Expected: [1, 2]) [18ms]</div>
<div style='color:#10b981; font-weight:700;'>&#10003; 2 / 2 Sample test cases passed successfully. Ready for evaluation submission.</div>";
        }

        protected void btnSubmitCode_Click(object sender, EventArgs e)
        {
            litConsoleOutput.Text = @"<div style='color:#10b981; font-size:12px; font-weight:800; margin-bottom:6px;'>&#10003; STATUS: ACCEPTED</div>
<div style='display:flex; gap:16px; margin-bottom:6px; font-size:11px;'>
    <span><strong>52 / 52</strong> Test cases passed</span>
    <span>Runtime: <strong style='color:#10b981;'>42 ms</strong> (faster than 88.4%)</span>
    <span>Memory: <strong style='color:#38bdf8;'>15.6 MB</strong> (less than 92.1%)</span>
</div>
<div style='color:#94a3b8; font-size:10px;'>Congratulations! Your solution passed all boundary and large-scale performance test cases.</div>";
        }
    }
}
