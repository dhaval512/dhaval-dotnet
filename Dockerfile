FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copy csproj and restore dependencies
COPY ["WeatherApi.csproj", "./"]
RUN dotnet restore "WeatherApi.csproj"

# Copy all files and build
COPY . .
RUN dotnet build "WeatherApi.csproj" -c Release -o /app/build
RUN dotnet publish "WeatherApi.csproj" -c Release -o /app/publish

# Generate runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "WeatherApi.dll"]
