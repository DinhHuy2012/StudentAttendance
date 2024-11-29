using BusinessObjects.DTO.EnrollmentDto;
using BusinessObjects.Models;
using Newtonsoft.Json;
using OfficeOpenXml;
using System.Text;

namespace StudentAttendanceClient.APIFunction
{
    public class EnrollmentAPI
    {
        private static readonly HttpClient client = new HttpClient();


        public static async Task<bool> AddStudentsToClassAsync(int classId, List<int> studentIds)
        {
            // Ensure studentIds is not null and contains values  
            if (studentIds == null || studentIds.Count == 0)
            {
                Console.WriteLine("Error: The studentIds field is required.");
                return false;
            }

            var url = "http://localhost:5019/api/Enrollment/AddStudentsToClass";

            var enrollmentRequest = new AddEnrollmentDTO
            {
                ClassId = classId,
                StudentIds = studentIds
            };

            // Serialize the request into JSON format  
            var json = JsonConvert.SerializeObject(enrollmentRequest);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            // Log the URL and JSON request  
            Console.WriteLine($"URL: {url}");
            Console.WriteLine($"Request JSON: {json}");

            try
            {
                using (var client = new HttpClient())
                {
                    using (var response = await client.PostAsync(url, content))
                    {
                        // Check the HTTP status code  
                        if (!response.IsSuccessStatusCode)
                        {
                            // Log error details  
                            var responseContent = await response.Content.ReadAsStringAsync();
                            Console.WriteLine($"Error: {response.StatusCode}, Details: {responseContent}");
                            return false;
                        }

                        Console.WriteLine("Students added successfully.");
                        return true;
                    }
                }
            }
            catch (HttpRequestException httpEx)
            {
                // Log HTTP error, e.g., connection issues  
                Console.WriteLine($"HTTP error occurred: {httpEx.Message}");
                return false;
            }
            catch (Exception ex)
            {
                // Log general errors  
                Console.WriteLine($"An error occurred: {ex.Message}");
                return false;
            }
        }


        public static async Task<bool> ImportFile(IFormFile file, int classId)
        {
            var url = "http://localhost:5019/api/Enrollment/import-from-excel";

            using (var memoryStream = new MemoryStream())
            {
                await file.CopyToAsync(memoryStream);
                memoryStream.Position = 0; // Reset the stream position to the beginning  

                var requestContent = new MultipartFormDataContent();
                var fileContent = new ByteArrayContent(memoryStream.ToArray());
                fileContent.Headers.ContentType = System.Net.Http.Headers.MediaTypeHeaderValue.Parse(file.ContentType);

                requestContent.Add(fileContent, "file", file.FileName);
                requestContent.Add(new StringContent(classId.ToString()), "classId");
                Console.WriteLine($"Sending classId: {classId}");
                try
                {
                    // Set LicenseContext for EPPlus  
                    ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

                    // Send the POST request  
                    using (var response = await client.PostAsync(url, requestContent))
                    {
                        if (!response.IsSuccessStatusCode)
                        {
                            var errorContent = await response.Content.ReadAsStringAsync();
                            Console.WriteLine($"Error: {errorContent}");
                            return false; // Or throw Exception if better for your flow  
                        }

                        return true; // Success  
                    }
                }
                catch (HttpRequestException httpEx)
                {
                    Console.WriteLine($"HTTP error occurred: {httpEx.Message}");
                    return false;
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"An error occurred: {ex.Message}");
                    return false;
                }
            }
        }

    }
}
