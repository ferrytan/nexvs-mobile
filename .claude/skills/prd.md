# PRD Writer & Brainstorming Skill

## Skill Overview

This skill helps you create comprehensive Product Requirement Documents (PRDs) through structured brainstorming and documentation. It follows the NEXVS PRD format.

## Usage

### For Brainstorming (Raw Notes)

Use this when you have rough notes, ideas, or requirements in any language:

```
/prd brainstorm --lang [language] --notes "[your raw notes]"
```

The skill will:
1. Parse your raw notes (supports mixed languages)
2. Extract key concepts, problems, and features
3. Structure them into PRD format
4. Ask clarifying questions when needed
5. Generate complete PRD documents

### For Creating PRD from Scratch

Use this when starting fresh:

```
/prd create --name "[Project Name]" --phase "[Phase Number]"
```

The skill will:
1. Guide you through brainstorming questions
2. Extract problem statement and pain points
3. Define target users and personas
4. Create user stories and epics
5. Generate complete PRD structure

### For Updating Existing PRD

Use this when refining existing documentation:

```
/prd update --file "[PRD file]" --section "[section name]"
```

## PRD Structure

The generated PRD will include:

### PRD-00: Overview
- Project Identity
- Brief Description
- Problem Statement
- Project Goals
- Scope (In/Out)
- Target Users & Personas
- Non-Functional Requirements
- Constraints & Assumptions
- Dependencies
- Open Questions

### PRD-01: Features
- Epic breakdown
- User stories with acceptance criteria
- Feature priority matrix
- Data requirements

### PRD-02: Frontend Specs
- Tech stack (Flutter/Dart)
- Architecture (Clean Architecture)
- Screen list
- Component library
- Design system

### PRD-03: Backend Specs
- Tech stack (Node.js/Firebase)
- Architecture (Serverless)
- Service layer
- Authentication
- Validation
- Error handling

### PRD-04: Database Schema
- Collection definitions
- Field types
- Indexes
- Security rules
- Relationships

### PRD-05: API Documentation
- Endpoints (RESTful)
- Request/Response formats
- Error codes
- Rate limiting

### PRD-06: Roadmap
- Timeline breakdown
- Sprint details
- Risk management
- Success metrics

## Tips for Best Results

1. **Be Specific in Notes**: Include actual pain points, user quotes, and specific problems
2. **Mention Constraints**: Budget, timeline, team size, technical limitations
3. **Define Target Users**: Who will use this? What are their current pain points?
4. **Include Success Metrics**: How will you measure success?
5. **Note Dependencies**: External services, APIs, databases needed

## Example Commands

```
# Brainstorm from rough notes
/prd brainstorm --lang indonesian --notes "Masalah utama: registrasi manual, input ke Challonge satu-satu butuh 1 jam"

# Create PRD for new project
/prd create --name "NEXVS" --phase "1"

# Update specific section
/prd update --file "prd/PRD-00-Overview.md" --section "Problem Statement"

# Generate all PRD documents at once
/prd generate --all
```

## File Organization

Generated PRDs are organized as:
```
prd/
├── PRD-00-Overview.md
├── PRD-01-Phase{N}-Features.md
├── PRD-02-Frontend-Specs.md
├── PRD-03-Backend-Specs.md
├── PRD-04-Database-Schema.md
├── PRD-05-API-Documentation.md
└── PRD-06-Roadmap.md
```
