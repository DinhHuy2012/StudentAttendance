using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.DTO;
using Newtonsoft.Json;
using System.Text;

namespace StudentAttendanceClient.APIFunction
{
    public class AuthAPI
    {
        private static readonly HttpClient client = new HttpClient();

        public static async Task<string> LoginByTeacher(TeacherLoginDTO loginDTO)
        {
            string url = "http://localhost:5019/api/auth/LoginByTeacher"; // Cập nhật đường dẫn API của bạn
            string data = JsonConvert.SerializeObject(loginDTO);
            var httpContent = new StringContent(data, Encoding.UTF8, "application/json");

            try
            {
                HttpResponseMessage response = await client.PostAsync(url, httpContent);
                if (response.IsSuccessStatusCode)
                {
                    var result = await response.Content.ReadAsStringAsync();
                    var tokenResult = JsonConvert.DeserializeObject<TokenResponse>(result);
                    Console.WriteLine("Teacher Token: " + tokenResult.Token);
                    return tokenResult.Token;
                }
                else
                {
                    Console.WriteLine("Error: " + response.StatusCode);
                    return null;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Request failed: " + ex.Message);
                return null;
            }
        }

        public static async Task<string> LoginByStudent(StudentLoginDTO loginDTO)
        {
            string url = "http://localhost:5019/api/auth/LoginByStudent"; // Cập nhật đường dẫn API của bạn
            string data = JsonConvert.SerializeObject(loginDTO);
            var httpContent = new StringContent(data, Encoding.UTF8, "application/json");

            try
            {
                HttpResponseMessage response = await client.PostAsync(url, httpContent);
                if (response.IsSuccessStatusCode)
                {
                    var result = await response.Content.ReadAsStringAsync();
                    var tokenResult = JsonConvert.DeserializeObject<TokenResponse>(result);
                    Console.WriteLine("Student Token: " + tokenResult.Token);
                    return tokenResult.Token;
                }
                else
                {
                    Console.WriteLine("Error: " + response.StatusCode);
                    return null;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Request failed: " + ex.Message);
                return null;
            }
        }
    }
    public class TokenResponse
    {
        public string Token { get; set; }
    }

}

