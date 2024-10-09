using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;

namespace StudentAttendanceClient.APIFunction
{
    public class ClassAPI
    {
        private static readonly HttpClient client = new HttpClient();
        public static async Task<List<Class>> GetListClassAsync()
        {
            string url = "http://localhost:5019/api/Class/GetAllClass";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<List<Class>>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<Class>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<Class>();
            }
        }
    }
}
