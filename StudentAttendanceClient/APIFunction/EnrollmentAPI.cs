using BusinessObjects.Models;
using Newtonsoft.Json;
using System.Text;

namespace StudentAttendanceClient.APIFunction
{
    public class EnrollmentAPI
    {
        private static readonly HttpClient client = new HttpClient();

        public static async Task<bool> AddStudentsToClassAsync(int classId, List<int> studentIds)
        {
            // Đường dẫn đến API
            var url = $"http://localhost:5019/api/Enrollment/AddStudentsToClass/{classId}";

            // Tạo đối tượng chứa classId và studentIds
            var enrollmentRequest = new
            {
                studentIds // Chỉ cần truyền studentIds
            };

            // Chuyển đổi đối tượng thành JSON
            var json = JsonConvert.SerializeObject(enrollmentRequest);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            // Gửi yêu cầu POST
            try
            {
                using (var response = await client.PostAsync(url, content))
                {
                    response.EnsureSuccessStatusCode(); // Kiểm tra mã trạng thái
                    return true; // Trả về true nếu thành công
                }
            }
            catch (Exception ex)
            {
                // Xử lý lỗi
                Console.WriteLine($"Error adding students to class: {ex.Message}");
                return false;
            }
        }

    }
}
