<script setup lang="ts">
import type { FileItem } from '../types/domain/file';
import type { Folder } from '../types/domain/folder';


interface FolderUI extends Folder {
    children?: FolderUI[]
    isOpen?: boolean
    isLoading?: boolean
}

const props = defineProps<{
    contents: FileItem[]
    selectedFile: FileItem | null
    selectedFolder: FolderUI | null
}>()

const emit = defineEmits<{
    (e: 'file-click', file: FileItem): void
}>()

const handleClick = (file: FileItem) => {
    emit('file-click', file)
}

const getFileIcon = (fileName: string) => {
    const ext = fileName.split('.').pop()?.toLowerCase() || ''
    switch (ext) {
        case 'pdf': return 'fa-file-pdf text-danger'
        case 'jpg':
        case 'jpeg':
        case 'png':
        case 'gif': return 'fa-file-image text-success'
        case 'doc':
        case 'docx': return 'fa-file-word text-primary'
        case 'xls':
        case 'xlsx': return 'fa-file-excel text-success'
        case 'ppt':
        case 'pptx': return 'fa-file-powerpoint text-warning'
        case 'txt': return 'fa-file-alt text-secondary'
        case 'zip':
        case 'rar': return 'fa-file-archive text-muted'
        default: return 'fa-file text-info'
    }
}
</script>

<template>
    <div>
        <ul class="list-group mb-3" v-if="contents.length">
            <li v-for="file in contents" :key="file.id" class="list-group-item list-group-item-action"
                :class="{ 'active': selectedFile?.id === file.id }" style="cursor: pointer;" @click="handleClick(file)">
                <i class="fas me-2" :class="getFileIcon(file.name)"></i>
                {{ file.name }}
            </li>
        </ul>

        <div v-if="selectedFile" class="text-center mt-5">
            <i class="fas fa-4x text-primary mb-3" :class="getFileIcon(selectedFile.name)"></i>
            <h4>{{ selectedFile.name }}</h4>
            <p class="text-muted small">
                <!-- Ukuran: {{ selectedFile.size ?? '-' }} KB | -->
                Ekstensi: {{ selectedFile.name.split('.').pop() ?? '-' }}
            </p>
        </div>

        <p v-else-if="contents.length === 0 && selectedFolder" class="text-muted fst-italic text-center mt-5">
            Folder ini kosong.
        </p>

        <p v-else class="text-muted fst-italic text-center mt-5">
            Pilih folder untuk melihat file.
        </p>
    </div>
</template>
