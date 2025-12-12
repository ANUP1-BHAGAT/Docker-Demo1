# # Use SDK image to build the project
# FROM mcr.microsoft.com/dotnet/sdk:8.0-windowsservercore-ltsc2022 AS build
# WORKDIR /src
# COPY . .
# RUN dotnet restore
# RUN dotnet publish -c Release -o /app

# # Runtime image
# FROM mcr.microsoft.com/dotnet/aspnet:8.0-windowsservercore-ltsc2022
# WORKDIR /app
# COPY --from=build /app .
# EXPOSE 8080
# ENTRYPOINT ["dotnet", "MyMvcApp.dll"]
# # 

# Build stage
# FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
# WORKDIR /src
# COPY . .
# RUN dotnet publish -c Release -o /app

# # Runtime stage
# FROM mcr.microsoft.com/dotnet/aspnet:9.0
# WORKDIR /app
# COPY --from=build /app .
# EXPOSE 8080
# ENTRYPOINT ["dotnet", "MyMvcApp.dll"]
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app .
EXPOSE 8080
ENTRYPOINT ["dotnet", "MyMvcApp.dll"]
